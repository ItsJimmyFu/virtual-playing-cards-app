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
    @State var isOnlineLobbyViewActive : Bool = false
    
    @State var cardsPerHand : Double = 5
    
    @State var showInvalidGameAlert : Bool = false
    @State var errorMessage : String = ""
    
    var colors : [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .cyan, .indigo, .mint, .teal]
    
    var body: some View {
        Form {
            if(!isOnline){
                PlayerSettingSection(players: $game.currentGameState.players)
            }
            CardSettingSection(selected: $game.currentGameState.deck, players: $game.currentGameState.players, cardsPerHand: $cardsPerHand)
            AdvancedSettingSection(showActiveCards: $game.settings.showActiveCards)
            
            Button(action: {
                if(game.currentGameState.players.count == 0){
                    showInvalidGameAlert = true
                    errorMessage = "Player"
                }
                else if(game.currentGameState.deck.count == 0) {
                    showInvalidGameAlert = true
                    errorMessage = "Deck"
                }
                else{
                    game.settings.cardsPerHand = Int(cardsPerHand)
                    game.start()
                    
                    if(isOnline){
                        game.currentGameState.players.append(Player(name: "", turn: 0, hand: [], color: .red))
                        game.saveToDatabase()
                        isOnlineLobbyViewActive = true
                    }
                    else{
                        isGameViewActive = true
                        game.isLocal = true
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
            .fullScreenCover(isPresented: $isOnlineLobbyViewActive, content: {
                OnlineLobbyView(gameManager: game)
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
