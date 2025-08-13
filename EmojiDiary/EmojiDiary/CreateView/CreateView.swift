//
//  CreateView.swift
//  EmojiDiary
//
//  Created by EunYoung Wang on 8/12/25.
//

import SwiftUI

struct CreateView: View {
  @State private var comment: String = "" //일기 본문내용
  @Binding var getDate: Date // 외부에서 받아오는 날짜
  
    private var titleFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "yyyy년 M월 d일"
        return f
    }
  
  var body: some View {
    // 상단 바
    VStack(spacing: 0) {
      ZStack {
        //뒤로가기 버튼
        HStack {
          Button(action: {print("뒤로 갔습니다")}){
            
          }
            
          
          Spacer()
        }
        .padding(.leading,30)
        
        
      }
    }
    .padding()
    .navigationTitle(titleFormatter.string(from: getDate))
    .navigationBarTitleDisplayMode(.inline)
    
    // 이모티콘 고르기
    HStack{
      Text("🩷")
        .font(.system(size: 45))
      Text("💔")
        .font(.system(size: 45))
      Text("💗")
        .font(.system(size: 45))
    }
    
    // 일기 작성란
    VStack {
      ZStack {
        TextEditor(text: $comment)
          .frame(width: 350, height: 400)
          .padding()
          .autocorrectionDisabled()
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.gray)
              .background(.yellow.opacity(0.1))
          )
          .font(.body)
        
        
        //가이드 텍스트 표시
        if comment.isEmpty {
          VStack {
            Text("일기를 작성하세요.")
              .padding()
              .opacity(0.35)
          }
        }
      }
    }
    
    
    
    //저장 버튼
    HStack {
      Spacer()
      Button(action: {print("일기저장")}) {
        Image(systemName: "plus.circle.fill")
          .font(.system(size: 45))
      }
      .padding(.trailing, 25)
      .padding(.top, 15)
    }
  }
}


#Preview {
  CreateView(getDate)
}
