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
    @Binding var hand : [Card]
    @State private var offsetRotation : CGFloat = 0
    @State var maxRotation : CGFloat = 0
    @State var selectedCards : [Card] = []
    @Binding var activeCards : [Card]
    
    let yShift : CGFloat = 40
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(hand.indices, id: \.self) { index in
                    let selected : Bool = selectedCards.contains(hand[index])
                    Button(action: {
                        if(selected){
                            selectedCards = selectedCards.filter { $0 != hand[index] }
                        }
                        else {
                            selectedCards.append(hand[index])
                        }
                    }) {
                        Image(hand[index].imagePath)
                            .resizable()
                            .background(GeometryReader { geometry in
                                Color.white
                                    .onAppear {
                                        cardHeight = geometry.size.height + yShift
                                    }
                            })
                            .border(selected ? Color.yellow : Color.black, width: selected ? 3 : 0.5)
                        
                    }
                    
                    .scaledToFit()
                    .frame(width: cardWidth)
                    .offset(x:0, y: selected ? -yShift : 0)
                    .rotationEffect(Angle(degrees: Double(10 * (index - hand.count / 2 - 3)) + 5), anchor: UnitPoint(x: 0, y: 1.05))
                    .offset(x:cardWidth/2)
                }
            }
            .rotationEffect(Angle(degrees: offsetRotation),anchor: UnitPoint(x: 0.5, y: 1))
            .highPriorityGesture(
                DragGesture()
                    .onChanged { gesture in
                        offsetRotation = offsetRotation + gesture.translation.width/CGFloat(50)
                        
                    }
                    .onEnded { _ in
                        if(hand.count/2 * 10 <= 50){
                            maxRotation = 0
                        }
                        else{
                            maxRotation = CGFloat(hand.count/2*10-50)
                        }
                        
                        if (offsetRotation > maxRotation) {
                            offsetRotation = maxRotation
                        }
                        if (offsetRotation < -maxRotation) {
                            offsetRotation = -maxRotation
                        }
                    }
            )
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 200+yShift, alignment: .bottom)
            .clipped()
            .padding()
        }
        Button(action: {
            hand = hand.filter { !selectedCards.contains($0)}
            activeCards = selectedCards
            selectedCards = []
            offsetRotation = 0
        }, label: {
            Text("Play Selected Cards")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.black)
                .bold()
                .padding(5)
                .border(Color.yellow, width:3)
                
        })
    }
}

#Preview {
    let cardWidth : CGFloat = 120
    @State var hand : [Card] = Card.largeSampleHand
    @State var activeCards : [Card] = []
    return AdvancedHandView(cardWidth: cardWidth, hand: $hand, activeCards: $activeCards)
}
