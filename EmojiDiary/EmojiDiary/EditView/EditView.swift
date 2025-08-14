//
//  EditView.swift
//
//  Created by EunYoung Wang on 8/12/25.
//

import SwiftUI

struct EditView: View {
  @State private var comment: String = "" //일기 본문내용
  @Binding var getDate: Date // 외부에서 받아오는 날짜
  @State private var upSheet: Bool = false
  @State private var alert: Bool = false
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
      Spacer(minLength: 70)
      // 이모티콘 선택 뷰
      SelectButtonView(feelEmoji: $feelEmoji, emojis: emojis)
      
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
        Divider()
          .background(Color.gray.opacity(0.3))
                      .padding(.horizontal, 25)  // 좌우 여백을 둬서 전체 너비보다 짧게
                      .padding(.top, 400)
        // 글자수 카운터(여백포함)
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
    .background(backGroundColor.ignoresSafeArea(.all, edges: .top))
    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
    .toolbar{
      ToolbarItem(placement: .topBarTrailing){
        Button(action: {upSheet = true}){
          Image(systemName: "ellipsis")
        } //actionsheet -> confirmationDialog로 변경
        .confirmationDialog("타이틀", isPresented: $upSheet){
          Button("수정"){
            //수정기능구현
          }
          Button("삭제"){
            alert = true
          }
          .alert("정말 삭제하시겠습니까?", isPresented: $alert){
            Button("네",role: .destructive){
              // 삭제기능 구현
            }
            Button("아니오", role: .cancel){}
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
      @Binding var feelEmoji: String // CreateView와 양방향 바인딩
      let emojis: [EditView.EmojisData]
      
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
    EditView(getDate: .constant(Date()))
  }
}

