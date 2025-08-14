//
//  EditView.swift
//
//  Created by EunYoung Wang on 8/12/25.
//

import SwiftUI

struct EditView: View {
  @State private var comment: String = "" //일기 본문내용
  @Binding var getDate: Date // 외부에서 받아오는 날짜
  @State private var UpSheet: Bool = false
  @State private var Alert: Bool = false
  @FocusState private var isTextEditorFocused: Bool // 키보드 생성
  @State var FeelEmoji: String = "" // 선택한 이모티콘 저장
  
  
  private var titleFormatter: DateFormatter {
    let f = DateFormatter()
    f.locale = Locale(identifier: "ko_KR")
    f.dateFormat = "yyyy년 M월 d일"
    return f
  }
  
  
  var body: some View {
    
    VStack(spacing: 0){
      Spacer(minLength: 50)
      // 이모티콘 선택 뷰
      SelectButtonView(FeelEmoji: $FeelEmoji, emojis: emojis)
      
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
              .fill(.gray.opacity(0.1))
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
        Divider()
          .background(Color.gray.opacity(0.3))
                      .padding(.horizontal, 25)  // 좌우 여백을 둬서 전체 너비보다 짧게
                      .padding(.top, 400)
        // 글자수 카운터
        // TODO: 글자수 제한 구현 (추후에 결정)
        VStack {
          Spacer()
          HStack {
            Spacer()
            Text("\(comment.count)")
              .opacity(0.5)
              .padding([.trailing, .bottom], 35)
              .padding(.bottom, 40)
          }
        }
      }
      Spacer()
    }
    .navigationTitle(titleFormatter.string(from: getDate))
    .navigationBarTitleDisplayMode(.inline)
    .toolbar{
      ToolbarItem(placement: .topBarTrailing){
        Button(action: {UpSheet = true}){
          Image(systemName: "ellipsis")
        } //actionsheet -> confirmationDialog로 변경
        .confirmationDialog("타이틀", isPresented: $UpSheet){
          Button("수정", action: {})
          Button("삭제"){
            // TODO: 메세지추가
            Alert = true
          }
          .alert("정말 삭제하시겠습니까?", isPresented: $Alert){
            Button("네"){/*데이터삭제*/}
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
    struct SelectButtonView: View {
      @Binding var FeelEmoji: String // CreateView와 양방향 바인딩
      let emojis: [EditView.EmojisData]
      
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
      }
    }



#Preview {
  NavigationStack{
    EditView(getDate: .constant(Date()))
  }
}

