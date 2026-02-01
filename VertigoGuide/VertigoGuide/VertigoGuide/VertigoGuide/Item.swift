//
//  Item.swift
//  VertigoGuide
//
//  Created by YOSSY PINHAS on 26/10/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
