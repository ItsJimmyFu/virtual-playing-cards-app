//
//  SettingsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var game : GameState = GameState.emptyGame
    
    @State var isGameViewActive : Bool = false

    @State var cardsPerHand : Double = 5
    
    @State var showInvalidGameAlert : Bool = false
    @State var errorMessage : String = ""
    
    var colors : [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .cyan, .indigo, .mint, .teal]
    
    var body: some View {
        Form {
            PlayerSettingSection(players: $game.players)
            CardSettingSection(selected: $game.deck, players: $game.players, cardsPerHand: $cardsPerHand)
            AdvancedSettingSection(showActiveCards: $game.showActiveCards)
            
            Button(action: {
                if(game.players.count == 0){
                    showInvalidGameAlert = true
                    errorMessage = "Player"
                }
                else if(game.deck.count == 0) {
                    showInvalidGameAlert = true
                    errorMessage = "Deck"
                }
                else{
                    game.cardsPerHand = Int(cardsPerHand)
                    game.dealHand()
                    isGameViewActive = true
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
                GameView(gameState: game)
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
    return SettingsView()
}
