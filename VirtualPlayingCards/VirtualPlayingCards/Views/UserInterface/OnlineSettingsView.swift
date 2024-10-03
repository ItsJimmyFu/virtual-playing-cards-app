//
//  OnlineSettingsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import SwiftUI

struct OnlineSettingsView: View {
    @StateObject var game : GameManager = GameManager.emptyGame
    
    @State var isGameViewActive : Bool = false

    @State var cardsPerHand : Double = 5
    
    @State var showInvalidGameAlert : Bool = false
    @State var errorMessage : String = ""
    
    var colors : [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .cyan, .indigo, .mint, .teal]
    
    var body: some View {
        Form {
            CardSettingSection(selected: $game.currentGameState.deck, players: $game.currentGameState.players, cardsPerHand: $cardsPerHand)
            AdvancedSettingSection(showActiveCards: $game.settings.showActiveCards)
            
            Button(action: {
                game.currentGameState.players.append(Player(name: "Jimmy", turn: 0, hand: [], color: .red))
                if(game.currentGameState.deck.count == 0) {
                    showInvalidGameAlert = true
                    errorMessage = "Deck"
                }
                else{
                    game.settings.cardsPerHand = Int(cardsPerHand)
                    //game.dealHand()
                    //game.saveToDatabase()
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
                GameView(gameManager: game)
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
    return OnlineSettingsView()
}
