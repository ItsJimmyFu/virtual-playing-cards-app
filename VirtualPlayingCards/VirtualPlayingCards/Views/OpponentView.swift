//
//  OpponentView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import SwiftUI

struct OpponentView: View {
    @ObservedObject var gameState : Game
    var body: some View {
        HStack {
            Spacer()
            ForEach(gameState.players.indices, id: \.self) {index in
                VStack {
                    Text(gameState.players[index].name)
                        .font(.headline)
                    ZStack {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .border(gameState.players[index].color)
                            //.border(player.turn == activePlayer ? Color.yellow : Color.black)
                        Text(String(gameState.players[index].hand.count))
                    }
                }
                .padding()
                .background((gameState.turn == index) ? Color.gray : Color.clear)
                Spacer()
            }
        }
    }
}

#Preview {
    @State var players: [Player] = Player.examplePlayers
    @State var game: Game = Game.sampleGame
    @State var turn: Int = 0
    return OpponentView(gameState: game)
}
