//
//  SettingsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import SwiftUI

struct SettingsView: View {
    @State var players: [Player] = []
    @State var newPlayerName = ""
    //@State var color : Color = Color.blue
    @StateObject var game : Game = Game.emptyGame
    @State var isGameViewActive : Bool = false
    
    //let colorOptions: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .cyan, .indigo, .mint, .teal]
    
    var body: some View {
        Form {
            Section(header: Text("Players")) {
                ForEach($players) { $player in
                    HStack {
                        Text(player.name)
                        Spacer()
                        ColorPicker("Select Color", selection: $player.color).pickerStyle(.navigationLink)
                            .labelsHidden()
                    }
                }
                .onDelete { indices in
                    players.remove(atOffsets: indices)
                }
                HStack {
                    TextField("Add Player", text: $newPlayerName)
                    Button(action: {
                        withAnimation {
                            let newPlayer = Player(name: newPlayerName, turn: players.count, hand: [], color: Color.black)
                            players.append(newPlayer)
                            print(newPlayer)
                            print(players)
                            newPlayerName = ""
                            
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newPlayerName.isEmpty)
                }
            }
            Section(header: Text("Cards")){
                //Allow Selection of User to pick cards in the game
            }
            Button(action: {
                game.deck = Card.defaultDeck.shuffled()
                game.players = players
                game.cardsPerHand = 5
                game.dealHand()
                isGameViewActive = true
                
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
    }
}

#Preview {
    return SettingsView()
}
