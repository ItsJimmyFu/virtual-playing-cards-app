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
    @StateObject var game : Game = Game.emptyGame
    @State var isGameViewActive : Bool = false
    
    @State var deck : [Card] = Card.defaultDeck
    @State var selected: [Card] = []
    
    @State var isAllCardsSelected: Bool = false
    
    @State var sliderValue : Double = 5
    
    @State var isPresentingColorPickerSheet : Bool = false
    @State var selectedPlayer : Player = Player.empty
    
    @State var showInvalidGameAlert : Bool = false
    @State var errorMessage : String = ""
    
    var colors : [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .cyan, .indigo, .mint, .teal]
    
    var body: some View {
        Form {
            Section(header: Text("Players")) {
                ForEach($players) { $player in
                    HStack {
                        Text(player.name)
                        Spacer()
                        ColorPicker("Select Color", selection: $player.color)
                            .pickerStyle(.navigationLink)
                            .labelsHidden()
                        /*
                        Button(action: {
                            isPresentingColorPickerSheet = true
                            selectedPlayer = player
                        }, label: {
                            Image(systemName: "paintpalette")
                                .foregroundColor(player.color)
                        })
                         */
                    }
                }
                .onDelete { indices in
                    players.remove(atOffsets: indices)
                }
                HStack {
                    TextField("Add Player", text: $newPlayerName)
                    Button(action: {
                        withAnimation {
                            if(newPlayerName.isEmpty) {
                                newPlayerName = "Player " + String(players.count+1)
                            }
                            
                            var unusedColors = colors
                            for player in players {
                                unusedColors.removeAll {$0 == player.color}
                            }
                            let newPlayer = Player(name: newPlayerName, turn: players.count, hand: [], color: unusedColors.count == 0 ? Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)) : unusedColors[0])
                            players.append(newPlayer)
                            newPlayerName = ""
                            
                        }
                        let maxSliderRange = ((selected.count == 0) || (players.count == 0)) ? Double(deck.count) : floor(Double(selected.count / (players.count == 0 ? 1 : players.count)))
                        sliderValue = sliderValue > maxSliderRange ? maxSliderRange : sliderValue
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
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
                        if(isAllCardsSelected) {
                            selected = deck
                        }
                        else {
                            selected = []
                        }
                        let maxSliderRange = ((selected.count == 0) || (players.count == 0)) ? Double(deck.count) : floor(Double(selected.count / (players.count == 0 ? 1 : players.count)))
                        sliderValue = sliderValue > maxSliderRange ? maxSliderRange : sliderValue
                        
                    }, label: {
                        Image(systemName: isAllCardsSelected ? "checkmark.square" : "square")
                            .font(.title)
                            .foregroundColor(isAllCardsSelected ? .blue : .gray)
                    })
                }
            })
            Section(header: Text("Cards Per Hand")) {
                VStack {
                    let maxSliderRange = ((selected.count == 0) || (players.count == 0)) ? Double(deck.count) : floor(Double(selected.count / (players.count == 0 ? 1 : players.count)))
                    Slider(
                        value: $sliderValue,
                        in: 0...(maxSliderRange == 0 ? 1 : maxSliderRange),
                        step: 1
                    )
                    Text("\(Int(sliderValue))")
                }
            }
            //Add DisclosureGroup
            Section(header: Text("Advanced Settings")) {
                HStack {
                    Text("Show Active Cards")
                    Spacer()
                    Button(action: {
                        //isAllCardsSelected.toggle()
                    }, label: {
                        Image(systemName: isAllCardsSelected ? "checkmark.square" : "square")
                            .font(.title)
                            .foregroundColor(isAllCardsSelected ? .blue : .gray)
                    })
                }
            }
            Button(action: {
                if(players.count == 0){
                    showInvalidGameAlert = true
                    errorMessage = "Player"
                }
                else if(selected.count == 0) {
                    showInvalidGameAlert = true
                    errorMessage = "Deck"
                }
                else{
                    game.deck = selected
                    game.cardsPerHand = Int(sliderValue)
                    game.players = players
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
        .sheet(isPresented: $isPresentingColorPickerSheet, content: {
            ColorPickerSheet(selectedColor: $selectedPlayer.color)
        })
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
