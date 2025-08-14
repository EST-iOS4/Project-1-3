//
//  ListView.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/12/25.
//

import Charts
import SwiftUI

struct Emoji2: Identifiable, Hashable {
    let id = UUID()
    let symbol: String
    let count: Int
    var image: Image { Image(systemName: symbol) }
}

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
    
    var chartData: [Emoji2] {
            switch selectedTab {
            case "all":
                return [
                    Emoji2(symbol: "sun.max", count: 12),
                    Emoji2(symbol: "cloud", count: 12),
                    Emoji2(symbol: "cloud.rain", count: 12),
                    Emoji2(symbol: "cloud.bolt", count: 12)
                ]
            case "sun.max":
                return [
                    Emoji2(symbol: "sun.max", count: 12)
                ]
            case "cloud":
                return [
                    Emoji2(symbol: "cloud", count: 12)
                ]
            case "cloud.rain":
                return [
                    Emoji2(symbol: "cloud.rain", count: 12)
                ]
            case "cloud.bolt":
                return [
                    Emoji2(symbol: "cloud.bolt", count: 12)
                ]
            default:
                return []
            }
        }
    
    let dummyData: [String] = ["사과", "바나나", "딸기", "수박","사과1", "바나나1", "딸기1", "수박2", "바나나2", "딸기2", "수박3", "바나나3", "딸기3", "수박4"]
    
    var body: some View {
        let monthFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 M월"
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter
        }()
        
        VStack {
            HStack {
                Button {
                    changeMonth(by: -1)
                    //추가로 월이 변경될 때 마다 SwiftData 가져와 차트와 그래프를 변경해야 한다.
                    
                } label: {
                    Image(systemName: "chevron.left")
                }
                Button {
                    //년월을 선택할 수 있도록 커스텀해줘야함
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
                    //추가로 월이 변경될 때 마다 SwiftData 가져와 차트와 그래프를 변경해야 한다.
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
                //MARK: - selectedTab 을 변경할 때 마다 호출
                .onChange(of: selectedTab, { oldValue, newValue in
                    //SwiftData 데이터를 값을 꺼내와서 호출
                })
                
                .pickerStyle(.segmented)
                .background(.white)
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
                    
                    ForEach(dummyData, id: \.self) { fruit in
                        Text(fruit)
                    }
                }
                .safeAreaInset(edge: .bottom, content: {
                    Divider()
                        .frame(height: 0.5)
                        .background(Color(.white))
                })
                .onChange(of: selectedTab) { _ in
                    withAnimation {
                        proxy.scrollTo("top", anchor: .top)
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

#Preview {
    ListView()
}
