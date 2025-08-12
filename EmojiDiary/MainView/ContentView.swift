//
//  ContentView.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    
    var body: some View {
        TabView {
            VStack() {
                Text("Project Name")
                    .font(.headline)
                    .fontWeight(.bold)
                
                DatePicker("", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ko"))
                    .padding()
                Spacer()
            }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("달력")
                }
            
            // 두 번째 탭
            Text("두 번째 화면")
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("통계")
                }
        }
    }
}

#Preview {
    ContentView()
}
