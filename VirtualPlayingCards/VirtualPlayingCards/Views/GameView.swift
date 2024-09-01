//
//  GameView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct GameView: View {
    @State var activeCards : [[Card]] = [[]]
    @Binding var game : Game
    @State var turn: Int = 0
    var body: some View {
        let cardWidth : CGFloat = 100
        NavigationView {
            VStack {
                Spacer()
                OpponentView(players: $game.players, activePlayer: $turn)
                Spacer()
                HStack{
                    Spacer()
                    DeckView(deck: $game.deck, cardWidth: 100, player: $game.players[turn])
                    Spacer()
                    ActiveCardsView(cardWidth: 100, activeCards: $activeCards)
                    Spacer()
                    
                }
                AdvancedHandView(cardWidth: 120, player: $game.players[turn], activeCards: $activeCards, turn: $turn, playerCount: $game.players.count)
                Spacer()
            }
        }
    }
}

#Preview {
    @State var game : Game = Game.sampleGame
    game.dealHand()
    return GameView(game: $game)
}
