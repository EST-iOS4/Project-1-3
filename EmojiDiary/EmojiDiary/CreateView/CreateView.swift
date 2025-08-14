//
//  EditView.swift
//
//  Created by EunYoung Wang on 8/12/25.
//

import SwiftUI

struct CreateView: View {
  @State private var comment: String = "" //일기 본문내용
  @Binding var getDate: Date // 외부에서 받아오는 날짜
  @FocusState private var isTextEditorFocused: Bool // 키보드 생성
  
    private var titleFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "yyyy년 M월 d일"
        return f
    }
  
  var body: some View {
    // 상단 바
    NavigationView {
      
      VStack(spacing: 35){
        
        // 이모티콘 고르기
       
          HStack{
            Button("🩷", action: {})
              .font(.system(size: 50))
            Button("💔", action: {})
              .font(.system(size: 50))
            Button("💗", action: {})
              .font(.system(size: 50))
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
                  .fill(.yellow.opacity(0.1))
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
        }
        .padding(.trailing, 25)
      }
      
      // 상단바
      .toolbar{
        // 뒤로가기 버튼
        ToolbarItem(placement: .navigationBarLeading){
          Button(action: {print("뒤로 갔습니다")}){
          }
          Spacer()
        }
      }
    }
    .padding()
    .navigationTitle(titleFormatter.string(from: getDate))
    .navigationBarTitleDisplayMode(.inline)
    
    // FIXME: ForEach로 바꿔보는건?
    // 이모티콘 고르기
    HStack{
      Button("🩷", action: {})
        .font(.system(size: 50))
      Button("💔", action: {})
        .font(.system(size: 50))
      Button("💗", action: {})
        .font(.system(size: 50))
    }
    
    // TODO: 글자수제한 추가?
    // 일기 작성란
    VStack {
      ZStack {
        TextEditor(text: $comment)
          .frame(width: 350, height: 400)
          .padding()
          .autocorrectionDisabled()
          .focused($isTextEditorFocused)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.gray.opacity(0.3))
              .fill(.yellow.opacity(0.1))
          )
          .font(.body)
          .onTapGesture {
            isTextEditorFocused = true
          }

        
        
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
    
  }
  
}


//#Preview {
//  CreateView(getDate)
//}

