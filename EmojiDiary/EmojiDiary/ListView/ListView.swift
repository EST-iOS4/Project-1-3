//
//  ListView.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/12/25.
//

import SwiftUI
import Charts

struct ListView: View {
    @State private var currentDate = Date()
    @State var selectedTab = "all"
    
    var tabs = ["all","🤗","🔥","😰","😱"]
    
    
    let dummyData: [String] = ["사과", "바나나", "딸기", "수박","사과1", "바나나1", "딸기1", "수박2", "바나나2", "딸기2", "수박3", "바나나3", "딸기3", "수박4"]
    
    var body: some View {
        let monthFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 M월"
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
                
                Text(monthFormatter.string(from: currentDate))
                    .font(.headline)
                    .frame(minWidth: 120)
                
                Button {
                    changeMonth(by: 1)
                    //추가로 월이 변경될 때 마다 SwiftData 가져와 차트와 그래프를 변경해야 한다.
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            
            VStack {
                Picker("", selection: $selectedTab) {
                    ForEach(tabs, id: \.self) {
                        Text($0)
                    }
                }
                //MARK: - selectedTab 을 변경할 때 마다 호출
                .onChange(of: selectedTab, { oldValue, newValue in
                    //SwiftData 데이터를 값을 꺼내와서 호출
                })
                .pickerStyle(.segmented)
                .padding()
                .background(.white)
                .cornerRadius(15)
                .padding()
            }
            
//            Chart(data, id: \.emoji) { element in
//                SectorMark(angle: .value("Usage", element.count), angularInset: 1.5)        //angularInset 으로 차트 사이 간격을 줄 수 있음
//                    .foregroundStyle(by: .value("Emoji", element.emoji))
//            }
//            .chartLegend(alignment: .center, spacing: 18)
//            .padding()
//            .scaledToFit()
            
            List {
                ForEach(dummyData, id: \.self) { fruit in
                        Text(fruit)
                    }
            }
            
            Spacer()
        }
        .padding()

    }
    //MARK: - 월 변경하는 메서드
    private func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
            selectedTab = tabs[0]
        }
    }
    
}

#Preview {
    ListView()
}
