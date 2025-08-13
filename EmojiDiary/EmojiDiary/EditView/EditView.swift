//
//  EditView.swift
//
//  Created by EunYoung Wang on 8/12/25.
//

import SwiftUI

struct EditView: View {
  @State private var comment: String = "" //일기 본문내용
  @Binding var getDate: String // 외부에서 받아오는 날짜
  @State private var UpSheet: Bool = false
  @State private var Alert: Bool = false
  
  
  var body: some View {
    // 상단 바
    NavigationView {
      
      VStack(spacing: 35){
        
        // 이모티콘 고르기
        // TODO: For Each로 변경예정
        HStack{
          Button("🩷", action: {})
            .font(.system(size: 50))
          Button("💔", action: {})
            .font(.system(size: 50))
          Button("💗", action: {})
            .font(.system(size: 50))
        }
        
        
        
        // 일기 작성란
        // FIXME: 키보드가 안올라오는것 같음
        VStack {
          ZStack {
            TextEditor(text: $comment)
              .frame(width: 350, height: 400)
              .padding()
              .autocorrectionDisabled()
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(Color.gray.opacity(0.25))
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
      }
      
      // 상단바
      .toolbar{
        // 뒤로가기 버튼
        ToolbarItem(placement: .navigationBarLeading){
          Button(action: {print("뒤로 갔습니다")}){
            Image(systemName:"chevron.backward")
          }
        }
        // 선택한 날짜
        ToolbarItem(placement: .principal){
          Text(getDate)
            .font(.system(size: 20))
        }
        // 수정&삭제 액션시트
        ToolbarItem(placement: .navigationBarTrailing){
          Button(action: {UpSheet = true}){
            Image(systemName: "ellipsis")

          } //actionsheet -> confirmationDialog로 변경
          .confirmationDialog("타이틀", isPresented: $UpSheet){
            Button("수정", action: {})
            Button("삭제"){
              Alert = true
            }
            .alert("정말 삭제하시겠습니까?", isPresented: $Alert){
              Button("네"){/*데이터삭제*/}
            }
          }
        }
      }
    }
  }
  
}



#Preview {
  EditView(getDate: .constant("2025-08-12")) //임시값
}

