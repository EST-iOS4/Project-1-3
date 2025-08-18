//
//  EditViewModel.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/17/25.
//

import Foundation
import SwiftData

@MainActor
final class EditViewModel: ObservableObject {
    @Published var content: String
    @Published var imageData: String
    
    private let diary: Item
    private let dataManager: DiaryDataManager
    
    init(diary: Item, dataManager: DiaryDataManager) {
        self.diary = diary
        self.dataManager = dataManager
        self.content = diary.content ?? ""
        self.imageData = diary.imageData
    }
    
    func updateDiary() {
        dataManager.updateDiary(diary, content: content, imageData: imageData)
    }
    
    func deleteDiary() {
        dataManager.delete(item: diary)
        print("삭제")
    }
}
