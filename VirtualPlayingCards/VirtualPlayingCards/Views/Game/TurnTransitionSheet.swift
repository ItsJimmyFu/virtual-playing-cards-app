//
//  TurnTransitionView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-02.
//

import SwiftUI

//Displays a sheet which tells the user the player who has the next turn
struct TurnTransitionSheet: View {
    @State var nextPlayer : Player
    @Binding var isPresentingTurnTransitionSheet : Bool
    var body: some View {
        ZStack {
            //Instructions for user with background of the next player's color
            VStack {
                Text("Pass to Next Player: \(nextPlayer.name)")
                    .font(.title)
                    .padding()
                    .background(nextPlayer.color)
                Text("Tap to Continue")
                    .font(.headline)
                    .padding()
            }
            //Add a tap gesture to a clear background to continue
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { _ in
                    isPresentingTurnTransitionSheet = false
                }
        }
    }
}

#Preview {
    @State var nextPlayer : Player = Player.curPlayer
    @State var isPresentingTurnTransitionSheet : Bool = true
    return TurnTransitionSheet(nextPlayer: nextPlayer, isPresentingTurnTransitionSheet : $isPresentingTurnTransitionSheet)
}
