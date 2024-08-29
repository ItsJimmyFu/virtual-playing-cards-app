//
//  GameView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct GameView: View {
    @State var activeCards : [Card] = []
    @State var opponents : [Player] = Player.defaultOpponents
    @State var turn: Int = 2
    
    var body: some View {
        let cardWidth : CGFloat = 100
        VStack {
            OpponentView(players: $opponents, activePlayer: $turn)
            Spacer()
            HStack{
                Spacer()
                DeckView(cardWidth: 100, activeCards: $activeCards)
                Spacer()
                ActiveCardsView(cardWidth: 100, activeCards: $activeCards)
                Spacer()
                
            }
            HandView(hand: Card.sampleHand, cardWidth: 200, activeCards: $activeCards)
        }
    }
}

#Preview {
    GameView()
}
