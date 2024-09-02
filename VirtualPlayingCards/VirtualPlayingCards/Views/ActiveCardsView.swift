//
//  ActiveCardsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

struct ActiveCardsView: View {
    @State var cardWidth : CGFloat
    @Binding var activeCards : [[Card]]
    @State var cardHeight : CGFloat = 150
    
    var body: some View {
        VStack {
            if(activeCards == []){
                HStack (spacing:0) {
                    EmptyCardView(cardWidth: cardWidth)
                }
                .frame(width: cardWidth)
            }
            else {
                ZStack {
                    ForEach(activeCards.indices, id: \.self) { idx in
                        HStack (spacing:0) {
                            ForEach(activeCards[idx].indices, id: \.self) { cardIdx in
                                let currentCard : Card = activeCards[idx][cardIdx]
                                let borderColor = currentCard.player?.color ?? Color.black
                                Image(currentCard.imagePath)
                                    .resizable()
                                    .background(Color.white)
                                    .border(borderColor, width:2)
                                    .scaledToFit()
                                    .frame(width: cardWidth, height: cardHeight)
                                    .offset(x:-CGFloat(cardIdx) * cardWidth + CGFloat(cardIdx)*cardWidth/5,y:  0)
                            }
                        }
                        .frame(width: cardWidth / 5 * (CGFloat(activeCards[idx].count) + 4) ,alignment: .topLeading)
                        .offset(y: cardHeight / 4 * CGFloat(idx))
                    }
                }
                .frame(height: cardHeight + cardHeight/4 * CGFloat(activeCards.count-1), alignment: .top)
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    @State var players: [Player] = Player.examplePlayers
    @State var activeCards : [[Card]] = [
        [Card(suit:"diamonds", rank: "2",player: players[0]), Card(suit:"hearts", rank: "2",player: players[0]), Card(suit: "clubs", rank: "2",player: players[0])],
        [Card(suit:"diamonds", rank: "4",player: players[1]), Card(suit:"hearts", rank: "4",player: players[1]), Card(suit: "clubs", rank: "4",player: players[1]),
            Card(suit: "spades", rank: "4",player: players[1])],
        [Card(suit:"diamonds", rank: "6",player: players[2]), Card(suit: "clubs", rank: "6",player: players[2])]]
    return ActiveCardsView(cardWidth: 200, activeCards: $activeCards)
}
