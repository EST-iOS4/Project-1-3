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
  @State var FeelEmoji: String = "" // 선택한 이모티콘 저장
  
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
    
    
    // 이모티콘 선택 뷰
    CreateSelectButtonView(FeelEmoji: $FeelEmoji, emojis: emojis)
    
    
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
  
  // EmojisData 이모티콘 데이터 형식
  struct EmojisData{
    let id: Int = UUID().hashValue
    let emoji: String
    let name: String
  }

  // emojis: 이모티콘 배열
  let emojis: [EmojisData] = [
    EmojisData(emoji:"sun.max",name:"기분 좋음"),
    EmojisData(emoji:"cloud",name:"그저 그럼"),
    EmojisData(emoji:"cloud.rain",name:"기분 안좋음"),
    EmojisData(emoji:"cloud.bolt",name:"개열받음")
  ]
}

// 이모티콘 버튼 뷰
struct CreateSelectButtonView: View {
  @Binding var FeelEmoji: String // CreateView와 양방향 바인딩
  let emojis: [CreateView.EmojisData]
  
  var body: some View{
    
    // 이모티콘 고르기
    VStack{
      HStack(spacing: 20){
        ForEach(emojis, id: \.id){ EmojisData in
          Button(action: {
            FeelEmoji = EmojisData.emoji
          })
          {
            Image(systemName: EmojisData.emoji)
            // 선택한 이모티콘만 스타일 변화
            // FIXME: 구름 이모티콘 선택시 모양 이상함. 수정예정
              .font(.system(size: FeelEmoji == EmojisData.emoji ? 60 : 50))
              .foregroundStyle(FeelEmoji == EmojisData.emoji ? .yellow : .black)
          }
          .overlay(
            RoundedRectangle(cornerSize: .init(width: 50, height: 50))
              .stroke(
                FeelEmoji == EmojisData.emoji ? Color.yellow.opacity(0.3) : Color.white
              )
          )
        }
      }
    }
    .padding()
  }
  
}











#Preview {
  CreateView(getDate: .constant(Date()))
}
