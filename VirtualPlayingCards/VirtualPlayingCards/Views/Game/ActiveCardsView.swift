//
//  ActiveCardsView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-10.
//

import SwiftUI

//A view to display the active cards in play
struct ActiveCardsView: View {
    @Binding var activeCards : [[Card]]
    @State var cardWidth : CGFloat
    @State var isPresentingDetailedActiveCardsSheet : Bool = false
    var body: some View {
        //If no cards have been played display the empty card view
        if(activeCards.count == 0){
            HStack (spacing:0) {
                EmptyCardView(cardWidth: cardWidth)
            }
            .frame(width: cardWidth)
        }
        else {
            //Display the simple active cards view and on drag gesture display the detailed active card sheet
            SimpleActiveCardsView(cardWidth: 100, activeCards: $activeCards.last!)
                .gesture(
                    DragGesture(minimumDistance: 0) // Detect touch down and move
                        .onChanged { _ in
                            isPresentingDetailedActiveCardsSheet = true
                        }
                        .onEnded { _ in
                            isPresentingDetailedActiveCardsSheet = false
                        }
                )
                .sheet(isPresented: ($isPresentingDetailedActiveCardsSheet), content: {
                    DetailedActiveCardsSheet(cardWidth:100,activeCards: $activeCards, isPresentingDetailedActiveCardsSheet: $isPresentingDetailedActiveCardsSheet)
                })
        }
    }
}

#Preview {
    @State var players: [Player] = Player.examplePlayers
    @State var activeCards : [[Card]] = [[
        Card(suit:"diamonds", rank: "2",player: players[0]), Card(suit:"hearts", rank: "2",player: players[0]), Card(suit: "clubs", rank: "2",player: players[0])]]
    return ActiveCardsView(activeCards: $activeCards, cardWidth: 150)
}
