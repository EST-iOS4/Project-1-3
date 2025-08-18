import SwiftUI

enum fontSize: String, CaseIterable, Identifiable {
    case small = "작게"
    case normal = "보통"
    case large = "크게"
    var id: String { rawValue }
    var fontSize: CGFloat {
        switch self {
        case .small: return 14
        case .normal: return 17
        case .large:  return 20
        }
    }
}

struct SettingView: View {
    @Binding var getFontSize: fontSize
    @State private var date = Date()
    @State private var text = ""
    
    private var preFont: Font {
        .system(size: getFontSize.fontSize, weight: .regular)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Divider()
                
                HStack {
                    Text("글자 크기")
                        .font(.system(size: 27))
                        .padding(.horizontal)
                        .padding(.vertical)
                    Spacer()
                }
                
                Picker("글자 크기 선택", selection: $getFontSize) {
                    ForEach(fontSize.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical)
                HStack {
                        Spacer()
                        Text("너무 맑고 초롱한 그 중 하나 별이여.")
                            .font(preFont)
                            .padding(.horizontal)
                            .padding(.vertical)
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        Text("그대만큼 사랑스러운 사람을 본 일이 없다.")
                            .font(preFont)
                            .padding(.horizontal)
                            .padding(.vertical)
                        Spacer()
                    }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}
