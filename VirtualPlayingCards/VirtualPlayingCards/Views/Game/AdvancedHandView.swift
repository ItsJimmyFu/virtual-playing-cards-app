//
//  AdvancedHandView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import SwiftUI

//A view to show the player's hand of cards and to play the selected cards
struct AdvancedHandView: View {
    @State var cardWidth : CGFloat
    @State var cardHeight : CGFloat? = nil
    @ObservedObject var gameManager : GameManager
    @State private var offsetRotation : CGFloat = 0
    @State var maxRotation : CGFloat = 0
    @State var selectedCards : [Card] = []
    @State var isPresentingTurnTransitionSheet : Bool = false
    
    let yShift : CGFloat = 40
    
    var body: some View {
        let player : Player = gameManager.currentGameState.players[gameManager.currentGameState.turn]
        VStack {
            ZStack {
                ForEach(player.hand.indices, id: \.self) { index in
                    let selected : Bool = selectedCards.contains(player.hand[index])
                    //Creating a button for each card to register tap gestures
                    Button(action: {
                        if(selected){
                            selectedCards = selectedCards.filter { $0 != player.hand[index] }
                        }
                        else {
                            selectedCards.append(player.hand[index])
                        }
                    }) {
                        //Display the card from the player's hand
                        Image(player.hand[index].imagePath)
                            .resizable()
                            .background(GeometryReader { geometry in
                                Color.white
                                    .onAppear {
                                        cardHeight = geometry.size.height + yShift
                                    }
                            })
                            //If card is selected add a border of the player's color
                            .border(selected ? player.color : Color.black, width: selected ? 3 : 0.5)
                        
                    }
                    .scaledToFit()
                    .frame(width: cardWidth)
                    //Shift the card up if the card is selected
                    .offset(x:0, y: selected ? -yShift : 0)
                    //rotate the card at a certain offset depending on its index in player.hand
                    .rotationEffect(Angle(degrees: Double(10 * (index - player.hand.count / 2 - 3)) + 5), anchor: UnitPoint(x: 0, y: 1.05))
                    .offset(x:cardWidth/2)
                }
            }
            .rotationEffect(Angle(degrees: offsetRotation),anchor: UnitPoint(x: 0.5, y: 1))
            //Add a drag gesture to rotate the player hand to allow the user to view all the cards
            .highPriorityGesture(
                DragGesture()
                    .onChanged { gesture in
                        offsetRotation = offsetRotation + gesture.translation.width/CGFloat(50)
                        
                    }
                    .onEnded { _ in
                        //prevent rotation if there are not enough cards in player's hand
                        if(player.hand.count/2 * 10 <= 50){
                            maxRotation = 0
                        }
                        else{
                            //Limit rotation based on the number of cards
                            maxRotation = CGFloat(player.hand.count/2*10-50)
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
            .offset(y:-10)
            .clipped()
            .padding()
            //Button to play the cards that are selected and present the turn transition sheet
            Button(action: {
                //Remove the selected cards from the players hand
                player.hand = player.hand.filter { !selectedCards.contains($0)}
                
                //Remove the most recent move from the player
                if(gameManager.currentGameState.activeCards.count > 0 && gameManager.currentGameState.activeCards[0].0 == player){
                    gameManager.currentGameState.activeCards.remove(at: 0)
                }
                //Add the new move
                if(selectedCards.count > 0) {
                    gameManager.currentGameState.activeCards.append((player,selectedCards))
                }
                selectedCards = []
                offsetRotation = 0
                gameManager.nextTurn()
                
                isPresentingTurnTransitionSheet = true

            }, label: {
                Text("Play Selected Cards")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                    .bold()
                    .padding(5)
                    .border(player.color, width:3)
                    
            })
        }
        .sheet(isPresented: $isPresentingTurnTransitionSheet, content: {
            TurnTransitionSheet(nextPlayer: gameManager.currentGameState.players[gameManager.currentGameState.turn], isPresentingTurnTransitionSheet: $isPresentingTurnTransitionSheet)
        })
    }
}

#Preview {
    let cardWidth : CGFloat = 120
    @State var player : Player = Player.examplePlayers[0]
    @State var activeCards : [[Card]] = []
    @State var playerCount: Int = 4
    @State var gameManager : GameManager = GameManager.sampleGame
    @State var isPresentingTurnTransitionSheet : Bool = false
    return AdvancedHandView(cardWidth: cardWidth, gameManager: gameManager)
}
