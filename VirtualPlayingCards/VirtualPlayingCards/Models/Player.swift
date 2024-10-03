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
    
    func encode() -> [String: Any] {
        let color = color
        
        return ["name" : name, "color": color.toHex(), "turn": turn, "hand": hand.map { $0.encode()}]
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

extension Color {
    func toHex() -> String {
        let components = self.cgColor?.components ?? [0, 0, 0, 0]
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)

        return String(format: "#%02X%02X%02X", r, g, b)
    }
    
    func toRGBString() -> String {
        let components = self.cgColor?.components ?? [0, 0, 0, 0]
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)

        return "RGB(\(r), \(g), \(b))"
    }
}
