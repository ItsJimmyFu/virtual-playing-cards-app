//
//  CardSettingView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-02.
//

import SwiftUI

struct CardSettingView: View {
    @Binding var deck : [Card]
    @Binding var selected : [Bool]
    
    let columns = [
            GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(deck.indices, id: \.self ) {index in
                        VStack {
                            Button (action: {
                                selected[index].toggle()
                            }, label: {
                                Image(deck[index].imagePath)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width/5)
                                    .border(Color.black)
                                    .background(selected[index] ? Color.gray.opacity(0.3) : Color.clear)
                            })
                        
                            Image(systemName: selected[index] ? "circle.circle.fill" : "circle")
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    @State var deck : [Card] = Card.defaultDeck
    @State var selected: [Bool] = Array(repeating: false, count: deck.count)
    return CardSettingView(deck: $deck, selected: $selected)
}
