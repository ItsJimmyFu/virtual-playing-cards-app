//
//  OpponentView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import SwiftUI

struct OpponentView: View {
    @Binding var players: [Player]
    @Binding var activePlayer: Int
    var body: some View {
        HStack {
            Spacer()
            ForEach(players.indices, id: \.self) {index in
                VStack {
                    Text(players[index].name)
                        .font(.headline)
                    ZStack {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .border(players[index].color)
                            //.border(player.turn == activePlayer ? Color.yellow : Color.black)
                        Text(String(players[index].hand.count))
                    }
                }
                .padding()
                .background(activePlayer == index ? Color.gray : Color.clear)
                Spacer()
            }
        }
    }
}

#Preview {
    @State var players: [Player] = Player.examplePlayers
    @State var activePlayer: Int = 1
    return OpponentView(players: $players, activePlayer: $activePlayer)
}
