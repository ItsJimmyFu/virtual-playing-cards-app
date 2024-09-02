//
//  AdvancedHandView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import SwiftUI

struct AdvancedHandView: View {
    @State var cardWidth : CGFloat
    @State var cardHeight : CGFloat? = nil
    @ObservedObject var gameState : Game
    @State private var offsetRotation : CGFloat = 0
    @State var maxRotation : CGFloat = 0
    @State var selectedCards : [Card] = []
    @Binding var activeCards : [[Card]]
    
    let yShift : CGFloat = 40
    
    var body: some View {
        let player : Player = gameState.players[gameState.turn]
        VStack {
            ZStack {
                ForEach(player.hand.indices, id: \.self) { index in
                    let selected : Bool = selectedCards.contains(player.hand[index])
                    Button(action: {
                        if(selected){
                            selectedCards = selectedCards.filter { $0 != player.hand[index] }
                        }
                        else {
                            selectedCards.append(player.hand[index])
                        }
                    }) {
                        Image(player.hand[index].imagePath)
                            .resizable()
                            .background(GeometryReader { geometry in
                                Color.white
                                    .onAppear {
                                        cardHeight = geometry.size.height + yShift
                                    }
                            })
                            .border(selected ? player.color : Color.black, width: selected ? 3 : 0.5)
                        
                    }
                    
                    .scaledToFit()
                    .frame(width: cardWidth)
                    .offset(x:0, y: selected ? -yShift : 0)
                    .rotationEffect(Angle(degrees: Double(10 * (index - player.hand.count / 2 - 3)) + 5), anchor: UnitPoint(x: 0, y: 1.05))
                    .offset(x:cardWidth/2)
                }
            }
            .rotationEffect(Angle(degrees: offsetRotation),anchor: UnitPoint(x: 0.5, y: 1))
            .highPriorityGesture(
                DragGesture()
                    .onChanged { gesture in
                        offsetRotation = offsetRotation + gesture.translation.width/CGFloat(50)
                        
                    }
                    .onEnded { _ in
                        if(player.hand.count/2 * 10 <= 50){
                            maxRotation = 0
                        }
                        else{
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
        }
        Button(action: {
            print(activeCards)
            player.hand = player.hand.filter { !selectedCards.contains($0)}

            if(activeCards.count > 0 && activeCards[0][0].player == player){
                activeCards.remove(at: 0)
            }
            
            if(selectedCards.count > 0) {
                activeCards.append(selectedCards)
            }
            selectedCards = []
            offsetRotation = 0
            gameState.nextTurn()

        }, label: {
            Text("Play Selected Cards")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.black)
                .bold()
                .padding(5)
                .border(player.color, width:3)
                
        })
    }
}

#Preview {
    let cardWidth : CGFloat = 120
    @State var player : Player = Player.examplePlayers[0]
    @State var activeCards : [[Card]] = []
    @State var playerCount: Int = 4
    @State var gameState : Game = Game.sampleGame
    return AdvancedHandView(cardWidth: cardWidth, gameState: gameState, activeCards: $activeCards)
}
