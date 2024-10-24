//
//  OnlineLobbyView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import SwiftUI

struct OnlineLobbyView: View {
    @ObservedObject var gameManager : GameManager
    @State var isHost : Bool
    @State var isGameViewActive : Bool = false

    var body: some View {
        VStack {
            Spacer()
            Text("GAME CODE")
                .underline()
            Text(gameManager.gameCode)
                .font(.system(size: 60))
                .bold()
                .padding(.bottom)
            
            Text("Players " + String(gameManager.currentGameState.players.count) + "/" + String(gameManager.settings.maxPlayers))
            ForEach(gameManager.currentGameState.players) {player in
                Text(player.name)
                    .frame(width:100, height: 20)
                    .padding()
                    .background(player.color)
            }
            if(isHost) {
                Button(action: {
                    isGameViewActive = true
                    gameManager.start()
                    gameManager.started = true
                    gameManager.saveToDatabase()
                }, label: {
                    Text("Start Game")
                })
                .foregroundStyle(Color.black)
                .padding(.top)
            }
            else{
                Text("Waiting For Host...")
                    .padding(.top)
            }
            Spacer()
            
            
        }
        .fullScreenCover(isPresented: $isGameViewActive, content: {
            GameView(gameManager: gameManager)
        })
        .onChange(of: gameManager.started) {_,newValue in
            if(!isHost && newValue == true){
                isGameViewActive = true
            }
        }
    }
}

#Preview {
    @State var gameManager: GameManager = GameManager.sampleGame
    return OnlineLobbyView(gameManager: gameManager, isHost: false)
}
