//
//  Player.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import Foundation
import SwiftUI

//Represents the details of a Player in the game and their hand of cards
class Player : Identifiable, Equatable, ObservableObject {
    let id: UUID
    var color: Color
    var name: String
    @Published var turn: Int
    @Published var hand: [Card]
    
    
    //Initializes a player with name, turn ordering, hand and color
    init(id: UUID = UUID(), name: String, turn: Int, hand: [Card],color: Color) {
        self.id = id
        self.name = name
        self.turn = turn
        self.hand = hand
        self.color = color
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return (lhs.id == rhs.id)
    }
    
}
//Create custom variables to be used in previews
extension Player {
    static let empty: Player = Player(name: "", turn: -1, hand: [], color: .red)
    
    static let examplePlayers: [Player] = [
        Player(name: "Bob", turn: 0, hand: Card.sampleHand, color: Color.red),
        Player(name: "Cal", turn: 1, hand: Card.sampleHand, color: Color.green),
        Player(name: "Dom", turn: 2, hand: Card.sampleHand, color: Color.blue),
        Player(name: "Ede", turn: 2, hand: Card.sampleHand, color: Color.orange)
    ]
    
    static let gamePlayers: [Player] = [
        Player(name: "Bob", turn: 0, hand: [], color: Color.red),
        Player(name: "Cal", turn: 1, hand: [], color: Color.green),
        Player(name: "Dom", turn: 2, hand: [], color: Color.blue),
        Player(name: "Ede", turn: 2, hand: [], color: Color.orange)
    ]
    
    static let curPlayer: Player = Player(name: "Jimmy", turn: 0, hand: [], color: Color.yellow)

}
