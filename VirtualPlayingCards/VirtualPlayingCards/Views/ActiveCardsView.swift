//
//  ActiveCardsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct ActiveCardsView: View {
    @State var cardWidth : CGFloat
    @Binding var activeCards : [Card]
    
    var body: some View {
        if(activeCards.count == 0){
            HStack (spacing:0) {
                EmptyCardView(cardWidth: cardWidth)
            }
            .frame(width: cardWidth)
        }
        else {
            HStack (spacing:0) {
                ForEach(activeCards.indices, id: \.self) { index in
                    Image(activeCards[index].imagePath)
                        .resizable()
                        .background(Color.white)
                        .border(Color.black,width:0.5)
                        .scaledToFit()
                        .frame(width: cardWidth)
                        .offset(x:-CGFloat(index) * cardWidth + CGFloat(index)*cardWidth/5,y:  0)
                }
            }
            .frame(width: cardWidth / 5 * (CGFloat(activeCards.count) + 4),alignment: .leading)
        }
    }
}

#Preview {
    //@State var activeCards : [Card] = [Card(suit:"diamonds", rank: "2")]
    //@State var activeCards : [Card] = [Card(suit:"diamonds", rank: "2"), Card(suit:"hearts", rank: "2")]
    @State var activeCards : [Card] = [Card(suit:"diamonds", rank: "2"), Card(suit:"hearts", rank: "2"), Card(suit: "clubs", rank: "2")]
    return ActiveCardsView(cardWidth: 200, activeCards: $activeCards)
}
