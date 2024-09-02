//
//  Player.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import Foundation
import SwiftUI

class Player : Identifiable, Equatable {
    let id: UUID
    var name: String
    var turn: Int
    var hand: [Card]
    var color: Color
    
    init(id: UUID = UUID(), name: String, turn: Int, hand: [Card],color: Color) {
        self.id = id
        self.name = name
        self.turn = turn
        self.hand = hand
        self.color = color
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return (lhs.name == rhs.name && lhs.color == rhs.color)
    }
    
}

extension Player {
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
