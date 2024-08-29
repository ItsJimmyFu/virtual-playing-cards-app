//
//  Player.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import Foundation

struct Player : Identifiable{
    let id: UUID
    let name: String
    let turn: Int
    let hand: [Card]
    
    init(id: UUID = UUID(), name: String, turn: Int, hand: [Card]) {
        self.id = id
        self.name = name
        self.turn = turn
        self.hand = hand
    }
}

extension Player {
    static let defaultOpponents: [Player] = [
        Player(name: "Player 1", turn: 0, hand: Card.sampleHand),
        Player(name: "Player 2", turn: 1, hand: Card.sampleHand),
        Player(name: "Player 3", turn: 2, hand: Card.sampleHand)
    ]
}
