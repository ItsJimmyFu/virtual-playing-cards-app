//
//  CardHandView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-19.
//

import SwiftUI

struct HandView: View {
    
    @State var hand : [Card]
    @State var selectedCards : [Bool] = Array(repeating: false, count: 10)
    @State var cardWidth : CGFloat
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
                        Button(action: {
                            selectedCards[index].toggle()
                        }) {
                            Image(hand[index].imagePath)
                                .resizable()
                                .background(GeometryReader { geometry in
                                    Color.white
                                        .onAppear {
                                            cardHeight = geometry.size.height + yShift
                                        }
                                })
                                .border(selectedCards[index] ? Color.yellow : Color.black, width: selectedCards[index] ? 2 : 0.5)
                        }
                        .scaledToFit()
                        .frame(width: cardWidth)
                        .offset(x:-CGFloat(index) * cardWidth + CGFloat(index)*cardWidth/5,y:  selectedCards[index] ? 0 : yShift)
                        .animation(.easeInOut(duration: 0.5), value: selectedCards[index])
                    }
                }
                .frame(width: cardWidth / 5 * (CGFloat(hand.count) + 4), height: cardHeight, alignment: .topLeading)
                .padding(.vertical,yShift)
            }
            .padding(.vertical, -yShift)
            Button(action: {
                activeCards = []
                for index in hand.indices {
                    if(selectedCards[index] == true){
                        activeCards.append(hand[index])
                    }
                }
                print(selectedCards)
                for index in selectedCards.indices.reversed() {
                    if(selectedCards[index] == true){
                        print(index)
                        if(index < hand.count){
                            hand.remove(at:index)
                        }
                    }
                }
                
                selectedCards = Array(repeating: false, count: hand.count)
                
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
    @State var playedCards : [Card] = []
    @State var hand : [Card] = Card.sampleDoubleHand
    return HandView(hand: hand, cardWidth: cardWidth, activeCards: $playedCards)
}
