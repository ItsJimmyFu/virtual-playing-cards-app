//
//  GameView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct GameView: View {
    @State var activeCards : [[Card]] = [[]]
    @State var players : [Player] = Player.examplePlayers
    @State var turn: Int = 0
    @State var hand: [Card] = [
        Card(suit: "hearts", rank: "ace",player: Player.curPlayer),
        Card(suit: "diamonds", rank: "5",player: Player.curPlayer),
        Card(suit: "clubs", rank: "jack",player: Player.curPlayer),
        Card(suit: "spades", rank: "king",player: Player.curPlayer),
        Card(suit: "red", rank: "joker",player: Player.curPlayer),
        Card(suit: "hearts", rank: "9",player: Player.curPlayer),
        Card(suit: "spades", rank: "10",player: Player.curPlayer)
    ]
        
    var body: some View {
        let cardWidth : CGFloat = 100
        VStack {
            Spacer()
            OpponentView(players: $players, activePlayer: $turn)
            Spacer()
            HStack{
                Spacer()
                DeckView(cardWidth: 100, player: $players[turn])
                Spacer()
                ActiveCardsView(cardWidth: 100, activeCards: $activeCards)
                Spacer()
                
            }
            AdvancedHandView(cardWidth: 120, player: $players[turn], activeCards: $activeCards, turn: $turn, playerCount: players.count)
            Spacer()
        }
    }
}

#Preview {
    GameView()
}
