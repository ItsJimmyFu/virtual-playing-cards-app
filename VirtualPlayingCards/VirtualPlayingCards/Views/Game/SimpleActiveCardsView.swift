//
//  ActiveCardsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

//Display a view for the cards in play in the game
struct SimpleActiveCardsView: View {
    @State var cardWidth : CGFloat
    @Binding var activeCards : (Player,[Card])
    @State var cardHeight : CGFloat = 150
    
    var body: some View {
        //Display a horizontal row of cards overlapping
        HStack (spacing:0) {
            ForEach($activeCards.1.indices, id: \.self) { cardIdx in
                let currentCard : Card = activeCards.1[cardIdx]
                let borderColor = activeCards.0.color
                //Display the card
                Image(currentCard.imagePath)
                    .resizable()
                    .background(Color.white)
                    .border(borderColor, width:2)
                    .scaledToFit()
                    .frame(width: cardWidth, height: cardHeight)
                    .offset(x:-CGFloat(cardIdx) * cardWidth + CGFloat(cardIdx)*cardWidth/5,y:  0)
            }
        }
        .frame(width: cardWidth / 5 * (CGFloat($activeCards.1.count) + 4) ,alignment: .topLeading)
    }
}

#Preview {
    @State var players: [Player] = Player.examplePlayers
    @State var activeCards : (Player,[Card]) = (players[0],[
        Card(suit:"diamonds", rank: "2"), Card(suit:"hearts", rank: "2"), Card(suit: "clubs", rank: "2")])
    return SimpleActiveCardsView(cardWidth: 200, activeCards: $activeCards)
}

