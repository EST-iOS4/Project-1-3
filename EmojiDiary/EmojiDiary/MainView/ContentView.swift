//
//  ContentView.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // 첫 번째 탭
            Text("첫 번째 화면")
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
