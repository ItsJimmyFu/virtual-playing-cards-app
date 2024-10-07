//
//  OnlineLobbyView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import SwiftUI

struct OnlineLobbyView: View {
    @ObservedObject var gameManager : GameManager
    var body: some View {
        VStack {
            Spacer()
            Text("GAME CODE")
                .underline()
            Text(gameManager.gameCode)
                .font(.system(size: 60))
                .bold()
                .padding(.bottom)
            
            Text("Players 4/8")
            ForEach(gameManager.currentGameState.players) {player in
                Text(player.name)
                    .frame(width:100, height: 20)
                    .padding()
                    .background(player.color)
            }
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Start Game")
            })
            .padding(.top)
            Spacer()
            
            
        }
    }
}

#Preview {
    @State var gameManager: GameManager = GameManager.sampleGame
    return OnlineLobbyView(gameManager: gameManager)
}
