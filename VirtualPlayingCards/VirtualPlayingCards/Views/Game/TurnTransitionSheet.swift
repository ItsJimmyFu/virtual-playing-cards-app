//
//  TurnTransitionView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-02.
//

import SwiftUI

struct TurnTransitionSheet: View {
    @State var nextPlayer : Player
    @Binding var isPresentingTurnTransitionSheet : Bool
    var body: some View {
        ZStack {
            VStack {
                Text("Pass to Next Player: \(nextPlayer.name)")
                    .font(.title)
                    .padding()
                    .background(nextPlayer.color)
                Text("Tap to Continue")
                    .font(.headline)
                    .padding()
            }
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
