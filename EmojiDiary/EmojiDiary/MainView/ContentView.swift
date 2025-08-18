import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @State private var date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    @State private var selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!

    @State private var navigationToSetting = false
    @State private var selectedDiary: Item? = nil
    @State private var navigationToCreate = false
    @State private var navigationToEdit = false
    
    @State private var getFontSize: fontSize = .normal
    
    var body: some View {
            TabView {
                NavigationStack {
                    VStack {
                        DatePicker(
                            "",
                            selection: $date,
                            in: ...Date(),
                            displayedComponents: [.date]
                        )
                        .padding(.top, 50)
                        .datePickerStyle(.graphical)
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                        .onChange(of: date) { _, newDate in
                            // 사용자가 날짜를 선택하면 선택 상태 반영 후 일기 존재 여부 확인 → 화면 전환 결정
                            selectedDate = newDate
                            checkDiary(for: newDate)
                        }

                        Spacer()
                    }
                    .navigationTitle("날짜를 눌러 오늘의 이야기를 담아보세요")
                    .navigationBarTitleDisplayMode(.inline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                    // 설정 화면으로 이동
                    .navigationDestination(isPresented: $navigationToSetting) {
                        SettingView(getFontSize: $getFontSize)
                            .toolbar(Visibility.hidden, for: .tabBar) // 탭바 숨김
                    }
                    // “???” 화면으로 이동
                    .navigationDestination(isPresented: $navigationToCreate) {
                        CreateView(
                            getDate: $selectedDate,
                            viewModel: CreateViewModel(
                                dataManager: DiaryDataManager(context: context)
                            ),
                            getFontSize: getFontSize
                        )

                        .onDisappear {
                            // 뒤로 갈 때 플래그 원복(다음 네비게이션을 위해)
                            navigationToCreate = false
                        }
                        .toolbar(Visibility.hidden, for: .tabBar)
                    }
                    
                    // “기존 기록 수정” 화면으로 이동
                    .navigationDestination(isPresented: $navigationToEdit) {
                        if let diary = selectedDiary {
                            let editVM = EditViewModel(
                                diary: diary,
                                dataManager: DiaryDataManager(context: context)
                            )
                            EditView(
                                getDate: $selectedDate,
                                getFontSize: getFontSize,
                                editViewModel: editVM
                            )
                            .onDisappear {
                                navigationToEdit = false
                            }
                            .toolbar(Visibility.hidden, for: .tabBar)
                        }
                    }

                    // 우상단 톱니바퀴 버튼 → 설정 화면으로 이동하는 버튼
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button { navigationToSetting = true } label: {
                                Image(systemName: "gearshape").imageScale(.large)
                            }
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("달력")
                }

                // 통계 탭
                ListView()
                    .toolbar(.visible, for: .tabBar)
                    .tabItem {
                        Image(systemName: "chart.pie")
                        Text("통계")
                    }
            }
        }
        
        /// 선택한 날짜의 0시~24시 범위에 일기가 있는지 확인하여
        /// 있으면 수정 화면으로, 없으면 생성 화면으로 네비게이션 플래그를 세팅.
        private func checkDiary(for date: Date) {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else { return }
            
            // SwiftData 프레디케이트: 해당 날짜에 생성된 Item만 조회
            let predicate = #Predicate<Item> {
                $0.createdAt >= startOfDay && $0.createdAt < endOfDay
            }
            let descriptor = FetchDescriptor<Item>(predicate: predicate)
            
            do {
                let result = try context.fetch(descriptor)
                if let diary = result.first {
                    // 기존 기록 있음 → 수정 화면
                    selectedDiary = diary
                    navigationToEdit = true
                } else {
                    // 기록 없음 → 생성 화면
                    navigationToCreate = true
                }
            } catch {
                // TODO: 사용자에게 에러 알림(UI)로 승격 고려
                print("❌ Fetch 실패: \(error.localizedDescription)")
            }
        }
    }
