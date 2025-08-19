import SwiftUI

enum fontSize: String, CaseIterable, Identifiable {
    case small = "작게"
    case normal = "보통"
    case large  = "크게"
    var id: String { rawValue }
    
    var point: CGFloat {
        switch self {
        case .small: 14
        case .normal: 17
        case .large:  20
        }
    }
}

struct SettingView: View {
    @AppStorage("app.fontSize") private var fontRaw: String = fontSize.normal.rawValue
    private var current: fontSize { fontSize(rawValue: fontRaw) ?? .normal }
    
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
                
                Picker("글자 크기 선택", selection: $fontRaw) {
                    ForEach(fontSize.allCases) { option in
                        Text(option.rawValue).tag(option.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical)
                
                HStack {
                    Spacer()
                    Text("너무 맑고 초롱한 그 중 하나 별이여.")
                        .font(.system(size: current.point))
                        .padding(.horizontal)
                        .padding(.vertical)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text("그대만큼 사랑스러운 사람을 본 일이 없다.")
                        .font(.system(size: current.point))
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
