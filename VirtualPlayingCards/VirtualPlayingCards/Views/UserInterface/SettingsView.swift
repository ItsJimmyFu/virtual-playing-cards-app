//
//  SettingsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var game : GameManager = GameManager.emptyGame
    @State var isOnline : Bool
    
    @State var isGameViewActive : Bool = false
    @State var isOnlineHostViewActive : Bool = false
    
    @State var cardsPerHand : Double = 5
    
    @State var showInvalidGameAlert : Bool = false
    @State var errorMessage : String = ""
    @State var username: String = ""
    
    var colors : [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .cyan, .indigo, .mint, .teal]
    
    var body: some View {
        Form {
            if(!isOnline){
                PlayerSettingSection(players: $game.currentGameState.players)
            }
            CardSettingSection(selected: $game.currentGameState.deck, players: $game.currentGameState.players, cardsPerHand: $cardsPerHand)
            AdvancedSettingSection(showActiveCards: $game.settings.showActiveCards)
            
            Button(action: {
                if(game.currentGameState.deck.count == 0) {
                    showInvalidGameAlert = true
                    errorMessage = "Deck"
                }
                else{
                    if(isOnline) {
                        game.settings.cardsPerHand = Int(cardsPerHand)
                        let currentPlayer: Player = Player(name: username, turn: 0, hand: [], color: .red)
                        game.currentGameState.players.append(currentPlayer)
                        game.startOnline(playerId: currentPlayer.id)
                        isOnlineHostViewActive = true
                    }
                    else{
                        if(game.currentGameState.players.count == 0){
                            showInvalidGameAlert = true
                            errorMessage = "Player"
                        }
                        game.settings.cardsPerHand = Int(cardsPerHand)
                        game.start()
                        game.isLocal = true
                        isGameViewActive = true
                    }
                }
                
            }, label: {
                Text("Start Game")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            .fullScreenCover(isPresented: $isGameViewActive, content: {
                GameView(gameManager: game)
            })
            .fullScreenCover(isPresented: $isOnlineHostViewActive, content: {
                OnlineLobbyView(gameManager: game, isHost: true)
            })
        }
        .alert(isPresented: $showInvalidGameAlert) {
            Alert(
                title: Text(errorMessage + " Missing"),
                message: Text("You cannot start the game until " + errorMessage + " is added"),
                dismissButton: .default(Text("OK")) {
                    showInvalidGameAlert = false
                    errorMessage = ""
                }
            )
        }
    }
}

#Preview {
    return SettingsView(isOnline: true)
}
