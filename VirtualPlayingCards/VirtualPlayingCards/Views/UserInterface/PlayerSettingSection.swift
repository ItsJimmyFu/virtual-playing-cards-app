//
//  PlayerSettingSection.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-11.
//

import SwiftUI

struct PlayerSettingSection: View {
    @State var newPlayerName = ""
    @Binding var players: [Player]
    var body: some View {
        let colors : [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .brown, .cyan, .indigo, .mint, .teal]
        
        Section(header: Text("Players")) {
            ForEach($players) { $player in
                HStack {
                    Text(player.name)
                    Spacer()
                    ColorPicker("Select Color", selection: $player.color)
                        .pickerStyle(.navigationLink)
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
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

#Preview {
    @State var players: [Player] = Player.examplePlayers
    return PlayerSettingSection(players: $players)
}
