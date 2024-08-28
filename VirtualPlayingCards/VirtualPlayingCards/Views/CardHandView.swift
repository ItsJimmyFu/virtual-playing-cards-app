//
//  CardHandView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-19.
//

import SwiftUI

struct CardHandView: View {
    
    @State var hand :[Card] = Card.sampleDoubleHand
    @State var selectedCards : [Bool] = Array(repeating: false, count: 100)
    let yShift : CGFloat = 75
    
    var body: some View {
        GeometryReader { geometry in
            //Get the width of the card image based on screen size and hand count
            //let cardWidth : CGFloat = geometry.size.width / (1 + CGFloat(hand.count-1) / 5)
            let cardWidth : CGFloat = 200
            
            ScrollView(.horizontal) {
                HStack (spacing:0) {
                    Spacer(minLength: 0)
                    ForEach(hand.indices, id: \.self) { index in
                        Button(action: {
                            selectedCards[index].toggle()
                        }) {
                            Image(hand[index].imagePath)
                                .resizable()
                                .background(Color.white)
                                .border(selectedCards[index] ? Color.yellow : Color.black,width: selectedCards[index] ? 2 : 0.5)
                        }
                        .scaledToFit()
                        .frame(width: cardWidth)
                        .offset(x:-CGFloat(index) * cardWidth + CGFloat(index)*cardWidth/5,y:  selectedCards[index] ? 0 : yShift)
                        .animation(.easeInOut(duration: 0.5), value: selectedCards[index])
                    }
                }
                .frame(width: cardWidth / 5 * (CGFloat(hand.count) + 4), alignment: .leading)
                .padding(.vertical,yShift)
            }
            .border(Color.black)
            .padding(.vertical, -yShift)
        }
        .padding()
    }
}

#Preview {
    return CardHandView()
}
