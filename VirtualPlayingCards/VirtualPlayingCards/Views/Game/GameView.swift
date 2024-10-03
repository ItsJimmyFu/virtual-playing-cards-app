//
//  GameView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI
// A view combining multiple different views for the entire game view
struct GameView: View {
    @State var activeCards : [[Card]] = []
    @ObservedObject var gameState : GameState
    
    var body: some View {
        //Set a constant for the width of a card
        let cardWidth : CGFloat = 100
        NavigationView {
            VStack {
                Spacer()
                PlayersView(gameState: gameState)
                Spacer()
                HStack{
                    Spacer()
                    DeckView(cardWidth: 100, gameState: gameState)
                    Spacer()
                    ActiveCardsView(activeCards: $activeCards, cardWidth: cardWidth)
                    Spacer()
                    
                }
                AdvancedHandView(cardWidth: 120, gameState: gameState, activeCards: $activeCards)
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    @State var gameState : GameState = GameState.sampleGame
    return GameView(gameState: gameState)
}
