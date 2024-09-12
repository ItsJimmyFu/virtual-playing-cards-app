//
//  CardSettingSection.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-12.
//

import SwiftUI

struct CardSettingSection: View {
    @State var deck : [Card] = Card.defaultDeck
    @Binding var selected: [Card]
    @State var isAllCardsSelected: Bool = false
    @Binding var players: [Player]
    @Binding var cardsPerHand : Double
    
    var body: some View {
        Section(content: {
            CardSettingView(deck: $deck, selected: $selected)
                .frame(height: 500) // 4 * cardHeight
                .padding(.vertical)
        }, header: {
            HStack {
                Text("Cards In Game")
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
                    value: $cardsPerHand ,
                    in: 0...(maxSliderRange == 0 ? 1 : maxSliderRange),
                    step: 1
                )
                Text("\(Int(cardsPerHand))")
            }
        }
    }
}

#Preview {
    @State var selected : [Card] = []
    @State var players : [Player] = Player.examplePlayers
    @State var cardsPerHand : Double = 5
    return CardSettingSection(selected: $selected, players: $players, cardsPerHand: $cardsPerHand)
}
