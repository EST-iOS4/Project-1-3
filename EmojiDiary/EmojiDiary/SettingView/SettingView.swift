//
//  SettingView.swift
//  EmojiDiary
//
//  Created by 강지원 on 8/13/25.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("fontSize") private var fontSize: Double = 17
    
    private var previewText: String { // 폰트 사이즈별로 미리보기 텍스트 return
        switch Int(fontSize) {
        case 7:
            return "작게"
        case 17:
            return "보통"
        case 27:
            return "크게"
        default:
            return "\(Int(fontSize))"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Setting")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                
            }
            HStack {
                Text("글자 크기")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                
                Slider(value: $fontSize, in: 7...27, step: 10) // 기본 폰트 사이즈 ± 10
                    .padding()
                
            }
            
            Text(previewText)
                .font(.system(size: 17 * (CGFloat(fontSize) / 17))) // return된 미리보기 텍스트 표시
                .padding(.top, 8)
            
        }
        
        Spacer()
    }
    
}

#Preview {
    SettingView()
}
