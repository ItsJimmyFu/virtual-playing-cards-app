//
//  GameView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct GameView: View {
    @State var activeCards : [Card] = []
    var body: some View {
        let cardWidth : CGFloat = 100
        VStack {
            HStack{
                Spacer()
                DeckView(cardWidth: 100, activeCards: $activeCards)
                Spacer()
                ActiveCardsView(cardWidth: 100, activeCards: $activeCards)
                Spacer()
                
            }
            HandView(cardWidth: 200)
        }
    }
}

#Preview {
    GameView()
}
