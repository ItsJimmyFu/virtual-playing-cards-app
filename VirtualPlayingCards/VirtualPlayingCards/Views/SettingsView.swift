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
    
    @State var deck : [Card] = Card.defaultDeck
    @State var selected: [Bool] = Array(repeating: false, count: 56)
    @State var isAllCardsSelected: Bool = false
    
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
            Section(content: {
                CardSettingView(deck: $deck, selected: $selected)
                    .frame(height: 500) // 4 * cardHeight
                    .padding(.vertical)
            }, header: {
                HStack {
                    Text("Cards")
                    Spacer()
                    Text( isAllCardsSelected ? "Unselect All" : "Select All")
                    Button(action: {
                        isAllCardsSelected.toggle()
                        selected = selected.map { _ in isAllCardsSelected }
                    }, label: {
                        Image(systemName: isAllCardsSelected ? "checkmark.square" : "square")
                            .font(.title)
                            .foregroundColor(isAllCardsSelected ? .blue : .gray)
                    })
                }
            })
            Button(action: {
                game.deck = []
                for index in deck.indices {
                    if(selected[index]) {
                        let card : Card = deck[index]
                        game.deck.append(card)
                    }
                }
                 
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
