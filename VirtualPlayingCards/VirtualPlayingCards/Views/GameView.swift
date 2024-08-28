//
//  GameView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        let cardWidth : CGFloat = 150
        VStack {
            DeckView(cardWidth: cardWidth)
            HandView(cardWidth: cardWidth)
        }
    }
}

#Preview {
    GameView()
}
