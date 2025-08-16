import SwiftUI

enum fontSize: String, CaseIterable, Identifiable {
    case small = "작게"
    case normal = "보통"
    case large = "크게"
    var id: String {
        rawValue
    }
    
    var fontSize: CGFloat {
        switch self {
        case .small:
            return 14
        case .normal:
            return 17
        case .large:
            return 20
        }
    }
}

struct SettingView: View {
    @State private var comment = ""
    @State private var getFontSize: fontSize = .normal
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                HStack {
                    Text("글자 크기")
                        .font(.system(size: 27))
                        .padding(.horizontal)
                        .padding(.vertical)
                    Spacer()
                    
                }
                Picker("글자 크기 선택", selection: $getFontSize) {
                    ForEach(fontSize.allCases) {
                        option in Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.large)
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }

    }
    
}

#Preview {
    SettingView()
}
