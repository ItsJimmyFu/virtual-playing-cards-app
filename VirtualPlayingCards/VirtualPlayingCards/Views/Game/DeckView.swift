//
//  DeckView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

//A view to display a deck of cards for the player to draw from
struct DeckView: View {
    @State var cardWidth : CGFloat
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        ZStack {
            //Display the Empty Card View if deck is empty
            if(gameManager.currentGameState.deck.count == 0){
                EmptyCardView(cardWidth: cardWidth)
            }
            ForEach(gameManager.currentGameState.deck.indices, id: \.self) { index in
                //Display the top card at the top of the deck and allow the user to tap and move the card to their hand
                if(index == (gameManager.currentGameState.deck.count-1)){
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: cardWidth)
                        .background(Color.white)
                        .border(Color.black,width:0.5)
                        .onTapGesture {
                            if(gameManager.currentGameState.turn == gameManager.getOnlinePlayer().turn) {
                                gameManager.drawCard()
                            }
                        }
                }
                else{
                    //Display the cards at the bottom of deck at a random offset position and rotation
                    let randomOffsetX = CGFloat(Float.random(in: -5...5))
                    let randomOffsetY = CGFloat(Float.random(in: -5...5))
                    let randomDegrees : Angle = .degrees(Double.random(in: -10...10))
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: cardWidth)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 0.5).rotationEffect(randomDegrees).offset(x:randomOffsetX, y:randomOffsetY)
                }
                
            }
        }
    }
}

#Preview {
    @State var game : GameManager = GameManager.sampleGame
    return DeckView(cardWidth: 200, gameManager: game)
}
