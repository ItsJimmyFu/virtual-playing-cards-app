//
//  DetailedActiveCardsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-02.
//

import SwiftUI

//Shows a history of the active cards in play from previous turns
struct DetailedActiveCardsSheet: View {
    @State var cardWidth : CGFloat
    @Binding var activeCards : [(Player,[Card])]
    @State var cardHeight : CGFloat = 150
    @Binding var isPresentingDetailedActiveCardsSheet : Bool
    
    var body: some View {
        ZStack {
            ForEach(activeCards.indices, id: \.self) { idx in
                //Display the active cards shifted down based on index
                SimpleActiveCardsView(cardWidth: cardWidth, activeCards: $activeCards[idx])
                    .frame(width: cardWidth / 5 * (CGFloat(activeCards[idx].1.count) + 4) ,alignment: .topLeading)
                    .offset(y: cardHeight / 4 * CGFloat(idx))
            }
        }
        .frame(height: cardHeight + cardHeight/4 * CGFloat(activeCards.count-1), alignment: .top)
        .padding(.vertical)
    }
}

#Preview {
    @State var players: [Player] = Player.examplePlayers
    @State var activeCards : [(Player,[Card])] = [
        (players[0],[Card(suit:"diamonds", rank: "2"), Card(suit:"hearts", rank: "2"), Card(suit: "clubs", rank: "2")]),
        (players[1],[Card(suit:"diamonds", rank: "4"), Card(suit:"hearts", rank: "4"), Card(suit: "clubs", rank: "4"), Card(suit: "spades", rank: "4")]),
        (players[2],[Card(suit:"diamonds", rank: "6"), Card(suit: "clubs", rank: "6")])]

    @State var isPresenting : Bool = false
    return DetailedActiveCardsSheet(cardWidth: 200, activeCards: $activeCards, isPresentingDetailedActiveCardsSheet: $isPresenting)
}

