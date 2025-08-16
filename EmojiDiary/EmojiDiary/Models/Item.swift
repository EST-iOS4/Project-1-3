//
//  Item.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/12/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    @Attribute(.unique) var id: UUID
    let createdAt: Date
    var imageData: Data
    var content: String?
    
    init(id: UUID, createdAt: Date, imageData: Data, content: String? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.imageData = imageData
        self.content = content
    }
}
