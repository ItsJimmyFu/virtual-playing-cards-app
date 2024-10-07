//
//  TurnTransitionView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-02.
//

import SwiftUI

//Displays a sheet which tells the user the player who has the next turn
struct TurnTransitionSheet: View {
    @State var gameManager : GameManager
    @State var next : Bool
    @Binding var isPresentingTurnTransitionSheet : Bool
    var body: some View {
        let nextPlayer : Player = next ? gameManager.currentGameState.getNextPlayer() : gameManager.currentGameState.getPreviousPlayer()
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
    @State var gameManager: GameManager = GameManager.sampleGame
    @State var isPresentingTurnTransitionSheet : Bool = true
    return TurnTransitionSheet(gameManager: gameManager, next: false, isPresentingTurnTransitionSheet : $isPresentingTurnTransitionSheet)
}
