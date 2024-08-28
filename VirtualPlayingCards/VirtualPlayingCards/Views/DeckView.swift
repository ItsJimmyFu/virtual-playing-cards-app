//
//  DeckView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct DeckView: View {
    @State var hand :[Card] = Card.defaultDeck
    @State var cardWidth : CGFloat
    @Binding var activeCards : [Card]
    
    var body: some View {
        ZStack {
            if(hand.count == 0){
                EmptyCardView(cardWidth: cardWidth)
            }
            ForEach(hand.indices, id: \.self) { index in
                if(index == (hand.count-1)){
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: cardWidth)
                        .background(Color.white)
                        .border(Color.black,width:0.5)
                        .onTapGesture {
                            activeCards = []
                            activeCards.append(hand.popLast()!)
                        }
                }
                else{
                    let randomOffsetX = CGFloat(Float.random(in: -5...5))
                    let randomOffsetY = CGFloat(Float.random(in: -5...5))
                    let randomDegrees : Angle = .degrees(Double.random(in: -10...10))
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: cardWidth)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 0.5).rotationEffect(randomDegrees).offset(x:randomOffsetX, y:randomOffsetY)
                }
                
            }
        }
    }
}

#Preview {
    @State var activeCards : [Card] = []
    return DeckView(cardWidth: 200,activeCards: $activeCards)
}
