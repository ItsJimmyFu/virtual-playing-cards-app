//
//  Player.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-29.
//

import Foundation
import SwiftUI

//Represents the details of a Player in the game and their hand of cards
class Player : NSObject, NSCopying, Identifiable, ObservableObject {
    let id: UUID
    var color: Color
    var name: String
    @Published var turn: Int
    @Published var hand: [Card]
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Player(id: self.id, name: self.name, turn: self.turn, hand: self.hand.map { $0.copy() as! Card }, color: self.color)
    }
    
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
        guard let color = Color.fromRGBString(colorStr) else {
            print("Invalid color in player")
            return
        }
        self.hand = []
        for card in hand {
            guard let newCard = Card.decode(from: card as! [String : Any]) else {
                    print("Invalid Card")
                    return
            }
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
        // Convert SwiftUI Color to UIColor
        let uiColor = UIColor(self)

        // Get the RGB components
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)

        // Convert to 0-255 range and format as string
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        
        return "\(r),\(g),\(b)"
    }
    
    // Convert RGB string to Color
    static func fromRGBString(_ rgbString: String) -> Color? {
        let components = rgbString.split(separator: ",").compactMap { Int($0) }
        
        guard components.count == 3,
              components[0] >= 0, components[0] <= 255,
              components[1] >= 0, components[1] <= 255,
              components[2] >= 0, components[2] <= 255 else {
            return nil 
        }
        
        return Color(red: Double(components[0]) / 255.0, green: Double(components[1]) / 255.0, blue: Double(components[2]) / 255.0)
    }
}
