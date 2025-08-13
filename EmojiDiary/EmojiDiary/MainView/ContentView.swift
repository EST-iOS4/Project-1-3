import SwiftUI


struct ContentView: View {
    @State private var date = Date()
    
    var body: some View {
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
                        
                        Button(action: {
                            // 설정 버튼 클릭 시 동작
                        }) {
                            Image(systemName: "gearshape")
                                .imageScale(.large)
                                .padding(.horizontal)
                        }
                    }
                }
                
                
                DatePicker("", selection: $date, displayedComponents: [.date]) //달력
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ko")) //yyyy mm 부분 영어 -> 한글
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
