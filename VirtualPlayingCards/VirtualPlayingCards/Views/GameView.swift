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
    @State var isPresentingDetailedActiveCardsSheet : Bool = false
    
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
                    if(activeCards.count == 0){
                        HStack (spacing:0) {
                            EmptyCardView(cardWidth: cardWidth)
                        }
                        .frame(width: cardWidth)
                    }
                    else {
                        ActiveCardsView(cardWidth: 100, activeCards: $activeCards.last!)
                            .gesture(
                                DragGesture(minimumDistance: 0) // Detect touch down and move
                                    .onChanged { _ in
                                        isPresentingDetailedActiveCardsSheet = true
                                    }
                                    .onEnded { _ in
                                        isPresentingDetailedActiveCardsSheet = false
                                    }
                            )
                    }
                    Spacer()
                    
                }
                AdvancedHandView(cardWidth: 120, gameState: gameState, activeCards: $activeCards)
                Spacer()
            }
            .sheet(isPresented: ($isPresentingDetailedActiveCardsSheet), content: {
                DetailedActiveCardsSheet(cardWidth:100,activeCards: $activeCards, isPresentingDetailedActiveCardsSheet: $isPresentingDetailedActiveCardsSheet)
            })
        }
    }
}

#Preview {
    @State var gameState : Game = Game.sampleGame
    return GameView(gameState: gameState)
}
