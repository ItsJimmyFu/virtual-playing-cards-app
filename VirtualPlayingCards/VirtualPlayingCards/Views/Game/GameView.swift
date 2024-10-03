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
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        //Set a constant for the width of a card
        let cardWidth : CGFloat = 100
        NavigationView {
            VStack {
                Spacer()
                PlayersView(gameManager: gameManager)
                Spacer()
                HStack{
                    Spacer()
                    DeckView(cardWidth: 100, gameManager: gameManager)
                    Spacer()
                    ActiveCardsView(activeCards: $activeCards, cardWidth: cardWidth)
                    Spacer()
                    
                }
                AdvancedHandView(cardWidth: 120, gameManager: gameManager, activeCards: $activeCards)
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    @State var gameManager : GameManager = GameManager.sampleGame
    return GameView(gameManager: gameManager)
}
