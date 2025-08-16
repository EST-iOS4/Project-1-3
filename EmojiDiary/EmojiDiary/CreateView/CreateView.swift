//
//  CreateView.swift
//  Created by EunYoung Wang on 8/12/25.
//

import SwiftUI

// 🔗 EditView의 이모지 모델을 그대로 사용 (타입 통일)
typealias EmojisData = EditView.EmojisData

struct CreateView: View {
  @Binding var getDate: Date
  @State private var comment = ""
  @State private var feelEmoji = ""
  @FocusState private var isTextEditorFocused: Bool
  @Environment(\.dismiss) private var dismiss

  private var titleFormatter: DateFormatter {
    let f = DateFormatter()
    f.locale = Locale(identifier: "ko_KR")
    f.dateFormat = "yyyy년 M월 d일"
    return f
  }

  
  let emojis: [EmojisData] = [
    EmojisData(emoji: "sun.max",    name: "기분 좋음"),
    EmojisData(emoji: "cloud",      name: "그저 그럼"),
    EmojisData(emoji: "cloud.rain", name: "기분 안좋음"),
    EmojisData(emoji: "cloud.bolt", name: "개열받음")
  ]

  var body: some View {
    VStack(spacing: 24) {

      
      SelectButtonView(feelEmoji: $feelEmoji, emojis: emojis)

      ZStack(alignment: .topLeading) {
        TextEditor(text: $comment)
          .frame(minHeight: 260)
          .padding()
          .autocorrectionDisabled()
          .focused($isTextEditorFocused)
          .overlay(
            RoundedRectangle(cornerRadius: 16)
              .stroke(Color.gray.opacity(0.3), lineWidth: 1)
          )
          .font(.body)

        if comment.isEmpty {
          Text("일기를 작성하세요.")
            .foregroundColor(.secondary)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
      }

      HStack {
        Spacer()
        Button {
          print("일기저장")
        } label: {
          Image(systemName: "plus.circle.fill")
            .font(.system(size: 45))
        }
      }
    }
    .padding(.horizontal, 20)
    .navigationTitle(titleFormatter.string(from: getDate))
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button { dismiss() } label: {
          Image(systemName: "chevron.left")
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    CreateView(getDate: .constant(Date()))
  }
}
