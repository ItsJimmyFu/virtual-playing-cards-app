//
//  CardHandView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-19.
//

import SwiftUI

struct CardHandView: View {
    
    @Binding var hand: [Card]
    
    var body: some View {
        GeometryReader {geometry in
            HStack (spacing: 0){
                ForEach(hand) { card in
                    Image(card.imagePath)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(width: geometry.size.width / CGFloat(hand.count))
                }
            }
        }
        .padding()
    }
}

#Preview {
    @State var hand = Array(Card.defaultDeck[1...6])
    return CardHandView(hand: $hand)
}
