//
//  ListView.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/12/25.
//

import Charts
import SwiftData
import SwiftUI

struct MonthYearPicker: UIViewRepresentable {
    @Binding var date: Date
    
    func makeUIView(context: Context) -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .yearAndMonth
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko_KR")
        picker.timeZone = TimeZone(identifier: "Asia/Seoul")
        picker.addTarget(context.coordinator, action: #selector(Coordinator.dateChanged(_:)), for: .valueChanged)
        return picker
    }
    
    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.date = date
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        var parent: MonthYearPicker
        init(parent: MonthYearPicker) {
            self.parent = parent
        }
        @objc func dateChanged(_ sender: UIDatePicker) {
            let comps = Calendar.current.dateComponents([.year, .month], from: sender.date)
            if let newDate = Calendar.current.date(from: comps) {
                parent.date = newDate
            }
        }
    }
}

struct ListView: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [Item]
    
    @State private var currentDate = Date()
    @State private var tempDate = Date()
    @State private var selectedTab = "all"
    @State private var showPicker = false
    
    var tabs = ["all","sun.max","cloud","cloud.rain","cloud.bolt"]
    
    let colorScale: [String: Color] = [
        "sun.max": .blue,
        "cloud": .red,
        "cloud.rain": .orange,
        "cloud.bolt": .purple
    ]
    
    let colorScalePairs: KeyValuePairs<String, Color> = [
        "sun.max": .blue,
        "cloud": .red,
        "cloud.rain": .orange,
        "cloud.bolt": .purple
    ]
    
    var legendKeys: [String] {
        selectedTab == "all" ? Array(tabs.dropFirst()) : chartData.map { $0.symbol }
    }
    
    var chartData: [Emoji] {
        var counts: [String: Int] = [:]
        for item in filteredItems {
            counts[item.imageData, default: 0] += 1
        }
        
        var data = counts.map { Emoji(symbol: $0.key, count: $0.value) }
        
        if selectedTab != "all" {
            data = data.filter { $0.symbol == selectedTab }
        }
        
        return data
    }
    
    //현재 선택한 연/월에 맞는 Item 필터링 결과를 출력
    var filteredItems: [Item] {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        
        var filtered = items.filter { item in
            let itemYear = calendar.component(.year, from: item.createdAt)
            let itemMonth = calendar.component(.month, from: item.createdAt)
            return itemYear == year && itemMonth == month
        }
        
        if selectedTab != "all" {
            filtered = filtered.filter { $0.imageData == selectedTab }
        }
        
        return filtered.sorted(by: { $0.createdAt < $1.createdAt })
    }
    
    var body: some View {
        let monthFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 M월"
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter
        }()
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter
        }()
        
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        changeMonth(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Button {
                        showPicker.toggle()
                    } label: {
                        Text(monthFormatter.string(from: currentDate))
                            .font(.headline)
                            .frame(minWidth: 120)
                    }
                    .sheet(isPresented: $showPicker) {
                        VStack {
                            MonthYearPicker(date: $tempDate)
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                            
                            Button("확인") {
                                currentDate = tempDate
                                showPicker = false
                                selectedTab = tabs[0]
                            }
                            .padding()
                        }
                        .presentationDetents([.height(250)])
                    }
                    
                    Button {
                        changeMonth(by: 1)
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                
                VStack {
                    Picker("", selection: $selectedTab) {
                        ForEach(tabs, id: \.self) { key in
                            if key == "all" {
                                Text("all").tag(key)
                            } else {
                                Image(systemName: key).tag(key)
                            }
                        }
                    }
                    .padding()
                    .pickerStyle(.segmented)
                }
                
                ScrollViewReader { proxy in
                    List {
                        Chart(chartData, id: \.id) { element in
                            SectorMark(angle: .value("Usage", element.count), angularInset: 1.0)        //angularInset 으로 차트 사이 간격을 줄 수 있음
                                .foregroundStyle(by: .value("Emoji", element.symbol))
                                
                                .annotation(position: .overlay) {
                                    Text("\(element.count)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                        }
                        .chartForegroundStyleScale(colorScalePairs)
                        .chartLegend(.hidden)
                        .padding()
                        .scaledToFit()
                        .id("top")
                        
                        HStack(spacing: 18) {
                            ForEach(legendKeys, id: \.self) { key in
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(colorScale[key] ?? .gray)
                                        .frame(width: 8, height: 8)
                                    Image(systemName: key)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        ForEach(filteredItems, id: \.id) { item in
                            NavigationLink(destination: EditView(getDate: item.createdAt, editViewModel: EditViewModel(diary: item, dataManager: DiaryDataManager(context: context)))) {
                                HStack {
                                    Image(systemName: item.imageData)
                                    VStack(alignment: .leading) {
                                        Text("\(item.createdAt, formatter: dateFormatter)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text(item.content ?? "")
                                            .lineLimit(1)
                                    }
                                }
                            }
                        }
                    }
                    .safeAreaInset(edge: .bottom, content: {
                        Divider()
                            .frame(height: 0.5)
                    })
                    .onChange(of: selectedTab) { _, _ in
                        withAnimation {
                            proxy.scrollTo("top", anchor: .top)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - 월 변경하는 메서드
    func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
            selectedTab = tabs[0]
        }
    }
}

//#Preview {
//    ListView()
//}
