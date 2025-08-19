//
//  EditView.swift
//
//  Created by EunYoung Wang on 8/12/25.
//

import SwiftUI

struct EditView: View {
    let getDate: Date // 외부에서 받아오는 날짜
    @State private var upSheet: Bool = false
    @State private var alert: Bool = false
    @Environment(\.dismiss) var dismiss
    @FocusState private var isTextEditorFocused: Bool // 키보드 생성
    private let backGroundColor = Color.gray.opacity(0.01) // 백그라운드컬러 통일
    let getFontSize: fontSize
    
    @ObservedObject var editViewModel: EditViewModel
    
    private var titleFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "yyyy년 M월 d일"
        f.timeZone = TimeZone(identifier: "Asia/Seoul")
        return f
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                // 이모티콘 선택 뷰
                SelectButtonView(feelEmoji: $editViewModel.imageData, emojis: emojis)
                    .padding(.top)

                // TODO: 글자수제한 추가?
                // 일기 작성란
                ZStack(alignment: .bottomTrailing){
                    TextEditor(text: $editViewModel.content)
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
                        .font(.system(size: getFontSize.point))
                        .onTapGesture {
                            isTextEditorFocused = true
                        }
                    
                    
                    // 가이드 텍스트 표시
                    if editViewModel.content.isEmpty {
                        Text("오늘 하루는 어떠셨나요?")
                            .padding()
                            .opacity(0.5)
                            .allowsHitTesting(false) // Add this for better UX
                    }
                    
                    Text("\(editViewModel.content.count) 자")
                        .foregroundStyle(.secondary)
                        .padding(.trailing)
                        .padding(.bottom, 10)
                        .allowsHitTesting(false)
                }
                Spacer()
            }
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
                        editViewModel.updateDiary()
                        dismiss()
                    }
                    Button("삭제", role: .destructive){
                        alert = true
                    }
                }
            }
        }
        .onTapGesture {
            isTextEditorFocused = false
        }
        .alert("정말 삭제하시겠습니까?", isPresented: $alert){
            Button("네",role: .destructive){
                editViewModel.deleteDiary()
                dismiss()
            }
            Button("아니오", role: .cancel){}
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
            HStack(spacing: 30){
                ForEach(emojis, id: \.id){ EmojisData in
                    Button(action: {
                        feelEmoji = EmojisData.emoji
                    })
                    {
                        Image(systemName: EmojisData.emoji)
                            .font(.system(size: 40))
                            .foregroundStyle(feelEmoji == EmojisData.emoji ? .yellow : .primary)
                            .frame(width: 60, height: 60)
                    }
                    .overlay(
                        Circle()
                            .stroke(
                                feelEmoji == EmojisData.emoji ? Color.yellow.opacity(0.3) : Color.clear,
                                lineWidth : 3
                            )
                    )
                }
            }
        }
    }
}



//#Preview {
//    NavigationStack{
//        EditView(getDate: .constant(Date()), editViewModel: editViewModel)
//    }
//}

