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
    @State var feelEmoji: String = "" // 선택한 이모티콘 저장
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject private var createViewModel: CreateViewModel
    
    init(getDate: Binding<Date>, viewModel: CreateViewModel) {
        self._getDate = getDate
        self.createViewModel = viewModel
    }
    
    private var titleFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "yyyy년 M월 d일"
        f.timeZone = TimeZone(identifier: "Asia/Seoul")
        return f
    }

    private let backGroundColor = Color.gray.opacity(0.01) // 백그라운드컬러 통일
    
    struct SelectButtonView2: View {
        @Binding var feelEmoji: String // CreateView와 양방향 바인딩
        
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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 이모티콘 선택 뷰
                SelectButtonView2(feelEmoji: $feelEmoji)
                    .padding(.top)

                // 일기 작성란
                ZStack {
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
                    
                    // 가이드 텍스트 표시
                    if comment.isEmpty {
                        Text("오늘 하루는 어떠셨나요?")
                            .padding()
                            .opacity(0.5)
                            .allowsHitTesting(false)
                    }
                }
                Spacer()
            }
        }
        .navigationTitle(titleFormatter.string(from: getDate))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장") {
                    createViewModel.saveDiary(for: getDate, imageData: feelEmoji, content: comment)
                    dismiss()
                }
                .disabled(feelEmoji.isEmpty)
            }
        }
        .onTapGesture {
            isTextEditorFocused = false
        }
        
    }
}

//#Preview {
//    CreateView(getDate: .constant(Date()), viewModel: CreateViewModel(dataManager: DiaryDataManager(context: context)))
//}
