//
//  OpponentView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import SwiftUI

//A view to display all of the players in the game and highlight the current player's turn
struct PlayersView: View {
    @ObservedObject var gameState : Game
    var body: some View {
        HStack {
            Spacer()
            ForEach(gameState.players.indices, id: \.self) {index in
                VStack {
                    //Display the player's name
                    Text(gameState.players[index].name)
                        .font(.headline)
                    //Display the player's number of cards
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
                //Highlight the background of it is the player's turn
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
    return PlayersView(gameState: game)
}
