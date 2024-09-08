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
    @State var cardHeight : CGFloat = 150
    
    var body: some View {
        HStack (spacing:0) {
            ForEach(activeCards.indices, id: \.self) { cardIdx in
                let currentCard : Card = activeCards[cardIdx]
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
        .frame(width: cardWidth / 5 * (CGFloat(activeCards.count) + 4) ,alignment: .topLeading)
    }
}

#Preview {
    @State var players: [Player] = Player.examplePlayers
    @State var activeCards : [Card] = [
        Card(suit:"diamonds", rank: "2",player: players[0]), Card(suit:"hearts", rank: "2",player: players[0]), Card(suit: "clubs", rank: "2",player: players[0])]
    return ActiveCardsView(cardWidth: 200, activeCards: $activeCards)
}

