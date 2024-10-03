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
        
        return ["name" : name, "color": color.toRGBString(), "turn": turn, "hand": hand.map { $0.encode()}]
    }
    
    func decode(from dict: [String: Any]) {
        guard let name = dict["name"] as? String,
              let turn = dict["turn"] as? Int,
              let hand = dict["hand"] as? [Any],
              let colorStr = dict["color"] as? String else {
            print("Invalid GameState")
            return
        }
        self.name = name
        self.turn = turn
        guard let color = Color.fromRGBString(rgbString: colorStr) else {
            print("Invalid color in player")
            return
        }
        self.hand = []
        for card in hand {
            let newCard : Card = Card.empty
            newCard.decode(from: card as! [String : Any])
            self.hand.append(newCard)
        }
        self.color = color
        
        
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
    func toRGBString() -> String {
        let components = self.cgColor?.components ?? [0, 0, 0, 0]
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)

        return "RGB(\(r), \(g), \(b))"
    }
    
    static func fromRGBString(rgbString: String) -> Color? {
            // Remove "RGB(" and ")" and trim whitespace
            let cleanedString = rgbString.replacingOccurrences(of: "RGB(", with: "").replacingOccurrences(of: ")", with: "").trimmingCharacters(in: .whitespaces)

            // Split the string by commas
            let components = cleanedString.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }

            // Ensure there are exactly three components
            guard components.count == 3,
                  let r = Double(components[0]),
                  let g = Double(components[1]),
                  let b = Double(components[2]),
                  r >= 0, r <= 255,
                  g >= 0, g <= 255,
                  b >= 0, b <= 255 else {
                return nil
            }

            return Color(red: r / 255.0, green: g / 255.0, blue: b / 255.0)
        }
}
