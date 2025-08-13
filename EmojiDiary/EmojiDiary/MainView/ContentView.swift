import SwiftUI


struct ContentView: View {
<<<<<<< HEAD
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
                    
                    
                    Text("선택된 날짜: \(getDate)")
                    
=======
    @State private var date = Date()
    @State private var selectedDate = Date()
    @State private var navigationToDetail = false
    
    var body: some View {
        // 첫 번째 화면
        NavigationStack {
            TabView {
                VStack() {
                    Text("EmojiDiary") //Project 제목
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    DatePicker("", selection: $date, displayedComponents: [.date]) //달력
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
                        
>>>>>>> 0628f8d525231c7d1cd758ac89c4174bc56412cf
                    Spacer()
                }
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("달력")
                    }
<<<<<<< HEAD
                
                    
                // 두 번째 탭
                Text("두 번째 화면")
                    .tabItem {
                        Image(systemName: "chart.pie")
                        Text("통계")
                        
                        
                    }
            }
        }

=======
                    
                // 두 번째 탭
                ListView()
                    .tabItem {
                        Image(systemName: "chart.pie")
                        Text("통계")
                    }
            }
        }
        .navigationDestination(isPresented: $navigationToDetail) {
            CreateView(getDate: $selectedDate)
        }
        
>>>>>>> 0628f8d525231c7d1cd758ac89c4174bc56412cf
    }
}

#Preview {
    ContentView()
}
