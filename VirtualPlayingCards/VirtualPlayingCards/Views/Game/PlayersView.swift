//
//  OpponentView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import SwiftUI

//A view to display all of the players in the game and highlight the current player's turn
struct PlayersView: View {
    @ObservedObject var gameManager : GameManager
    var body: some View {
        HStack {
            Spacer()
            ForEach(gameManager.currentGameState.players.indices, id: \.self) {index in
                VStack {
                    //Display the player's name
                    Text(gameManager.currentGameState.players[index].name)
                        .font(.headline)
                    //Display the player's number of cards
                    ZStack {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .border(gameManager.currentGameState.players[index].color)
                            //.border(player.turn == activePlayer ? Color.yellow : Color.black)
                        Text(String(gameManager.currentGameState.players[index].hand.count))
                    }
                }
                .padding()
                //Highlight the background of it is the player's turn
                .background((gameManager.currentGameState.turn == index) ? Color.gray : Color.clear)
                Spacer()
            }
        }
    }
}

#Preview {
    @State var game: GameManager = GameManager.sampleGame
    return PlayersView(gameManager: game)
}
