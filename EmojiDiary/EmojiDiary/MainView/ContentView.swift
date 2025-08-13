import SwiftUI


struct ContentView: View {
    @State private var getDate = Date()
    
    var body: some View {
        NavigationStack {
            // 첫 번째 화면
            TabView {
                // 첫 번째 탭
                Text("첫 번째 화면")

                VStack() {
                    ZStack{
                        Text("Project Name") //Project 제목
                            .font(.headline)
                            .padding(.horizontal)
                        HStack{
                            Spacer()
                            
                            
                            NavigationLink(destination: SettingView()) {
                                Image(systemName: "gearshape")
                                    .imageScale(.large)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    
                    
                    DatePicker("", selection: $getDate, in: ...Date(), displayedComponents: [.date]) //달력
                        .datePickerStyle(.graphical)
                        .environment(\.locale, Locale(identifier: "ko")) //yyyy mm 부분 영어 -> 한글
                        .padding(.horizontal)
                    
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
}

#Preview {
    ContentView()
}
