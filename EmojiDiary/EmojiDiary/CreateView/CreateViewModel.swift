//
//  CreateViewModel.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/17/25.
//

import Foundation

@MainActor
final class CreateViewModel: ObservableObject {
    private let dataManager: DiaryDataManager
    
    @Published var savedDiary: Item?
    
    init(dataManager: DiaryDataManager) {
        self.dataManager = dataManager
    }
    
    func saveDiary(for date: Date, imageData: String, content: String?) {
        let diary = dataManager.createDiary(for: date, imageData: imageData, content: content)
        savedDiary = diary
    }
}
