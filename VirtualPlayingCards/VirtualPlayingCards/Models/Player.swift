//
//  Player.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import Foundation
import SwiftUI

struct Player : Identifiable{
    let id: UUID
    let name: String
    let turn: Int
    var hand: [Card]
    let color: Color
    
    init(id: UUID = UUID(), name: String, turn: Int, hand: [Card],color: Color) {
        self.id = id
        self.name = name
        self.turn = turn
        self.hand = hand
        self.color = color
    }
}

extension Player {
    static let examplePlayers: [Player] = [
        Player(name: "Bob", turn: 0, hand: Card.sampleHand, color: Color.red),
        Player(name: "Cal", turn: 1, hand: Card.sampleHand, color: Color.green),
        Player(name: "Dom", turn: 2, hand: Card.sampleHand, color: Color.blue),
        Player(name: "Ede", turn: 2, hand: Card.sampleHand, color: Color.orange)
    ]
    
    static let curPlayer: Player = Player(name: "Jimmy", turn: 0, hand: [], color: Color.yellow)

}
