//
//  ColorOption.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-04.
//

import Foundation
import SwiftUI

struct ColorOption: Identifiable, Equatable {
    var id = UUID()
    var color: Color
    
    init(id: UUID = UUID(), color: Color) {
        self.id = id
        self.color = color
    }
    
    
}

extension ColorOption {
    static let colors : [ColorOption] = [ColorOption(color: .red), ColorOption(color: .green), ColorOption(color: .blue), ColorOption(color:.yellow), ColorOption(color:.orange), ColorOption(color:.purple), ColorOption(color:.pink), ColorOption(color:.brown), ColorOption(color:.cyan), ColorOption(color:.indigo), ColorOption(color:.mint), ColorOption(color:.teal)]
}
