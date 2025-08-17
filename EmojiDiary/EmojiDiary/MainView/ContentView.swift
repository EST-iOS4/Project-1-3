import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var date = Date()
    @State private var selectedDate = Date()
    @State private var navigationToSetting = false
    @State private var selectedDiary: Item? = nil
    @State private var navigationToCreate = false
    @State private var navigationToEdit = false
    @State private var getFontSize: fontSize = .normal
    
    @Environment(\.modelContext) private var context
    
    private var dateBinding: Binding<Date> {
        Binding(
            get: { self.date },
            set: { newDate in
                self.date = newDate
                self.selectedDate = newDate
                checkDiary(for: newDate)
            }
        )
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack() {
                    HStack {
                        Spacer()
                        Button {
                            navigationToSetting = true
                        } label: {
                            Image(systemName: "gearshape")
                                .imageScale(.large)
                                .padding(.vertical)
                                .padding(.horizontal)
                        }
                    }
                    
                    Text("날짜를 눌러 오늘의 이야기를 담아보세요")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    
                    DatePicker("", selection: dateBinding, in: ...Date(), displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .environment(\.locale, Locale(identifier: "ko"))
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .navigationDestination(isPresented: $navigationToSetting) {
                    SettingView(getFontSize: $getFontSize)
                    .toolbar(Visibility.hidden, for: ToolbarPlacement.tabBar) }
                
                .navigationDestination(isPresented: $navigationToCreate) {
                    CreateView(
                        getDate: $date,
                        viewModel: CreateViewModel (
                            dataManager: DiaryDataManager(context: context),
                        ),
                        getFontSize: getFontSize,
                    )
                    .toolbar(Visibility.hidden, for: ToolbarPlacement.tabBar)
                }
                
                .navigationDestination(isPresented: $navigationToEdit) {
                    if let diary = selectedDiary {
                        let editVM = EditViewModel(diary: diary, dataManager: DiaryDataManager(context: context))
                        EditView(
                            getDate: $selectedDate,
                            getFontSize: getFontSize, editViewModel: editVM
                        )
                            .toolbar(Visibility.hidden, for: ToolbarPlacement.tabBar)
                    }
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
    
    private func checkDiary(for date: Date) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else { return }
        
        let predicate = #Predicate<Item> {
            $0.createdAt >= startOfDay && $0.createdAt < endOfDay
        }
        
        let descriptor = FetchDescriptor<Item>(predicate: predicate)
        
        do {
            let result = try context.fetch(descriptor)
            if let diary = result.first {
                selectedDiary = diary
                navigationToEdit = true
            } else {
                navigationToCreate = true
            }
        } catch {
            print("❌ Fetch 실패: \(error.localizedDescription)")
        }
    }
}




//#Preview {
//    ContentView()
//}
