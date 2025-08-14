//
//  ContentView.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    @State private var selectedDate = Date()
    @State private var navigationToSetting = false
    @State private var navigationToDetail = false
    
    var body: some View {
        // 첫 번째 화면
        NavigationStack {
            TabView {
                VStack() {
                    ZStack {
                        Text("날짜를 눌러 오늘의 이야기를 남겨보세요")
                            .font(.headline)
                            .fontWeight(.bold)
                        HStack {
                            Spacer()
                            Button {
                                navigationToSetting = true
                            } label: {
                                Image(systemName: "gearshape")
                                    .imageScale(.large)
                                    .padding(.trailing)
                            }
                            .navigationDestination(isPresented: $navigationToSetting) {
                                SettingView()
                            }
                        }
                    }
                    
                    DatePicker("", selection: $date, in: ...Date(),  displayedComponents: [.date]) //달력
                        .datePickerStyle(.graphical)
                        .environment(\.locale, Locale(identifier: "ko")) //yyyy mm 부분 영어 -> 한글
                        .padding()
                        .onChange(of: date) { oldValue, newValue in
                            selectedDate = newValue
                            navigationToDetail = true
                        }
                        .navigationDestination(isPresented: $navigationToDetail) {
                            CreateView(getDate: $date)
                        }
                    
                    Spacer()
                }
                
                .tabItem {
                    Image(systemName: "calendar")
                    Text("달력")
                }
                
                // 두 번째 탭
                ListView()
                    .tabItem {
                        Image(systemName: "chart.pie")
                        Text("통계")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
