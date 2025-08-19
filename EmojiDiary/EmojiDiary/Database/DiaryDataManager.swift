//
//  EmojiDataManager.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/16/25.
//

import Foundation
import SwiftData


final class DiaryDataManager {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // Create
    func createDiary(for date: Date, imageData: String, content: String?) -> Item? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        let startOfDay = calendar.startOfDay(for: date)
        
        let newItem = Item(
            id: UUID(),
            createdAt: startOfDay,
            imageData: imageData,
            content: content
        )
        context.insert(newItem)
        
        do {
            try context.save()
            return newItem
        } catch {
            print("❌ Create 실패: \(error.localizedDescription)")
            return nil
        }
    }
    
    //Update
    func updateDiary(_ diary: Item, content: String, imageData: String) {
        diary.content = content
        diary.imageData = imageData
        
        do {
            try context.save()
        } catch {
            print("❌ Failed to update Diary: \(error.localizedDescription)")
        }
    }
    
    // Delete
    func delete(item: Item) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("❌ Failed to delete Diary: \(error.localizedDescription)")
        }
    }
}

