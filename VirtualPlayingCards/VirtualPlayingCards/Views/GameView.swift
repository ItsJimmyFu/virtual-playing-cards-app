//
//  GameView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct GameView: View {
    @State var activeCards : [[Card]] = []
    @ObservedObject var gameState : Game
    var body: some View {
        let cardWidth : CGFloat = 100
        NavigationView {
            VStack {
                Spacer()
                OpponentView(gameState: gameState)
                Spacer()
                HStack{
                    Spacer()
                    DeckView(cardWidth: 100, gameState: gameState)
                    Spacer()
                    ActiveCardsView(cardWidth: 100, activeCards: $activeCards)
                    Spacer()
                    
                }
                AdvancedHandView(cardWidth: 120, gameState: gameState, activeCards: $activeCards)
                Spacer()
            }
        }
    }
}

#Preview {
    @State var gameState : Game = Game.sampleGame
    return GameView(gameState: gameState)
}
