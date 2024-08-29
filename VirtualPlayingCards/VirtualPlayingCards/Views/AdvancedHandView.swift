//
//  AdvancedHandView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import SwiftUI

struct AdvancedHandView: View {
    @State var cardWidth : CGFloat
    @State var cardHeight : CGFloat? = nil
    var hand : [Card] = Card.largeSampleHand
    @State private var offsetRotation : CGFloat = 0
    @State var maxRotation : CGFloat = 0
    
    var body: some View {
        ZStack {
            ForEach(hand.indices, id: \.self) { index in
                Image(hand[index].imagePath)
                    .resizable()
                    .background(Color.white)
                    .border(Color.black,width:0.5)
                    .scaledToFit()
                    .frame(width: cardWidth)
                    .rotationEffect(Angle(degrees: Double(10 * (index - hand.count / 2))), anchor: UnitPoint(x: 0, y: 1))
                    .offset(x:cardWidth/2)
            }
        }
        .rotationEffect(Angle(degrees: offsetRotation),anchor: UnitPoint(x: 0.5, y: 1))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offsetRotation = offsetRotation + gesture.translation.width/CGFloat(50)
              
                }
                .onEnded { _ in
                    if (offsetRotation > maxRotation) {
                        offsetRotation = maxRotation
                    }
                    if (offsetRotation < -maxRotation) {
                        offsetRotation = -maxRotation
                    }
                }
        )
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 220, alignment: .bottom)
        .clipped()
        .onAppear {
            maxRotation = CGFloat(hand.count*10/4)
        }
    }
}

#Preview {
    let cardWidth : CGFloat = 120
    return AdvancedHandView(cardWidth: cardWidth)
}
