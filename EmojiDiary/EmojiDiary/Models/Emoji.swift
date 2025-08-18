
//
//  Emoji2.swift
//  EmojiDiary
//
//  Created by 서정원 on 8/18/25.
//

import Foundation
import SwiftUI

struct Emoji: Identifiable, Hashable {
    let id = UUID()
    let symbol: String
    let count: Int
    var image: Image { Image(systemName: symbol) }
}
