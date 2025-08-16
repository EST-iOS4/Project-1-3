import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    @State private var selectedDate = Date()
    @State private var navigationToSetting = false
    @State private var navigationToDetail = false
    @State private var comment = ""
    @State private var getFontSize: fontSize = .normal
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack() {
                    DatePicker("", selection: $date, in: ...Date(), displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .environment(\.locale, Locale(identifier: "ko"))
                    
                        .onChange(of: date) { _, newValue in
                            selectedDate = newValue
                            navigationToDetail = true
                        }
                }
                
                .navigationTitle("날짜를 눌러 오늘의 이야기를 담아보세요")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            navigationToSetting = true
                        } label: {
                            Image(systemName: "ellipsis")
                                .imageScale(.large)
                                .padding(.vertical)
                                .padding(.horizontal)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                .navigationDestination(isPresented: $navigationToSetting) {
                    SettingView() }
                .navigationDestination(isPresented: $navigationToDetail) {
                    CreateView(getDate: $date, text: $comment, size: getFontSize)
                }
            }
            
            .tabItem {
                Image(systemName: "calendar")
                Text("달력")
            }
            ListView()
                .toolbar(.visible, for: .tabBar)
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
