//
//  CardHandView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-19.
//

import SwiftUI

struct HandView: View {
    
    @Binding var hand : [Card]
    @State var cardWidth : CGFloat
    @State var selectedCards : [Card] = []
    @Binding var activeCards : [Card]
    
    
    let yShift : CGFloat = 40
    @State private var cardHeight : CGFloat? = nil
    
    var body: some View {
        VStack {
            //Get the width of the card image based on screen size and hand count
            //let cardWidth : CGFloat = geometry.size.width / (1 + CGFloat(hand.count-1) / 5)
            ScrollView(.horizontal) {
                HStack (spacing:0) {
                    Spacer(minLength: 0)
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
                                .border(selected ? Color.yellow : Color.black, width: selected ? 2 : 0.5)
                        }
                        .scaledToFit()
                        .frame(width: cardWidth)
                        .offset(x:-CGFloat(index) * cardWidth + CGFloat(index)*cardWidth/5,y:  selected ? 0 : yShift)
                        .animation(.easeInOut(duration: 0.5), value: selected)
                    }
                }
                .frame(width: cardWidth / 5 * (CGFloat(hand.count) + 4), height: cardHeight, alignment: .topLeading)
                .padding(.vertical,yShift)
            }
            .padding(.vertical, -yShift)
            Button(action: {
                hand = hand.filter { !selectedCards.contains($0)}
                activeCards = selectedCards
                selectedCards = []
            }, label: {
                Text("Play Cards")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                    .bold()
                    .padding(5)
                    .border(Color.yellow, width:1)
                    
            })
        }
        .padding()
    }
}

#Preview {
    let cardWidth : CGFloat = 200
    @State var activeCards : [Card] = []
    @State var hand : [Card] = Card.sampleDoubleHand
    return HandView(hand: $hand, cardWidth: cardWidth, activeCards: $activeCards)
}
