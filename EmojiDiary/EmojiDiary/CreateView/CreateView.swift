//
//  CreateView.swift
//
//  Created by EunYoung Wang on 8/12/25.
//

import SwiftUI

struct CreateView: View {
  @State private var comment: String = "" //일기 본문내용
  @Binding var getDate: Date // 외부에서 받아오는 날짜
  @FocusState private var isTextEditorFocused: Bool // 키보드 생성
  @State var feelEmoji: String = "" // 선택한 이모티콘 저장
  private let backGroundColor = Color.gray.opacity(0.01) // 백그라운드컬러 통일
  
  
  private var titleFormatter: DateFormatter {
    let f = DateFormatter()
    f.locale = Locale(identifier: "ko_KR")
    f.dateFormat = "yyyy년 M월 d일"
    return f
  }
  
  
  var body: some View {
    
    VStack(spacing: 0){
      Spacer(minLength: 60)
      // 이모티콘 선택 뷰
      CreateSelectButtonView(feelEmoji: $feelEmoji, emojis: emojis)
      
      Spacer(minLength: 40)
      
      // TODO: 글자수제한 추가?
      // 일기 작성란
      ZStack{
        TextEditor(text: $comment)
          .frame(width: 350, height: 460)
          .lineSpacing(5)
          .padding()
          .autocorrectionDisabled()
          .focused($isTextEditorFocused)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.gray.opacity(0.3))
              .fill(backGroundColor)
          )
          .font(.body)
          .onTapGesture {
            isTextEditorFocused = true
          }
        
        
        //가이드 텍스트 표시
        if comment.isEmpty {
          Text("오늘 하루는 어떠셨나요?")
            .padding()
            .opacity(0.5)
        }
        
        
        //구분자
        Rectangle()
          .fill(Color.gray.opacity(0.3))
          .frame(height: 1)
          .padding(.horizontal, 25)
          .padding(.top, 400)
        
        
        // 글자수 카운터(여백포함)
        // TODO: 글자수 제한 구현 (추후에 결정)
        VStack {
          Spacer()
          HStack {
            Spacer()
            Text("\(comment.count) 자")
              .opacity(0.5)
              .padding(.horizontal, 40)
              .padding(.vertical, 15)
          }
        }
      }
      Spacer()
      
      
      //저장 버튼
      HStack {
        Spacer()
        // TODO: 저장버튼 누르면 메인뷰로 돌아가기
        Button(action: {print("일기저장")}) {
          Image(systemName: "plus.circle.fill")
            .font(.system(size: 50))
            .foregroundStyle(Color.yellow)
        }
        .padding([.horizontal, .vertical])
        .padding(.trailing)
      }
      
    }
    .navigationTitle(titleFormatter.string(from: getDate))
    .navigationBarTitleDisplayMode(.inline)
    .background(backGroundColor.ignoresSafeArea(.all, edges: .top))
    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
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
  @Binding var feelEmoji: String // CreateView와 양방향 바인딩
  let emojis: [CreateView.EmojisData]
  
  var body: some View{
    
    // 이모티콘 고르기
    VStack{
      HStack(spacing: 20){
        ForEach(emojis, id: \.id){ EmojisData in
          Button(action: {
            feelEmoji = EmojisData.emoji
          })
          {
            Image(systemName: EmojisData.emoji)
            // 선택한 이모티콘만 스타일 변화
              .font(.system(size: feelEmoji == EmojisData.emoji ? 60 : 50))
              .foregroundStyle(feelEmoji == EmojisData.emoji ? .yellow : .black)
          }
          .overlay(
            Circle()
              .stroke(
                feelEmoji == EmojisData.emoji ? Color.yellow.opacity(0.3) : Color.white,
                lineWidth : 3
              )
              .frame(width: 100, height: 100)
          )
        }
      }
    }
  }
}



#Preview {
  NavigationStack{
    CreateView(getDate: .constant(Date()))
  }
}



