//
//  SettingView.swift
//  EmojiDiary
//
//  Created by 강지원 on 8/13/25.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            Text("Setting")
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            ZStack {
                Text("Coming Soon")
                    .font(.title)
                    .foregroundColor(.black)
                    
            }
            Spacer()
        }
        
    }
}

#Preview {
    SettingView()
}
