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
            ForEach(players) {player in
                VStack {
                    Text(player.name)
                        .font(.headline)
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75)
                        .border(player.turn == activePlayer ? Color.yellow : Color.black)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    @State var players: [Player] = Player.defaultOpponents
    @State var activePlayer: Int = 1
    return OpponentView(players: $players, activePlayer: $activePlayer)
}
