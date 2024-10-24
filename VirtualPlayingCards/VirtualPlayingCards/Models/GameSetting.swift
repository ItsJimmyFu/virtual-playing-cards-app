//
//  GameSetting.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import Foundation

class GameSetting : ObservableObject {
    @Published var cardsPerHand : Int
    @Published var showActiveCards : Bool
    @Published var maxPlayers: Int
    
    init(cardsPerHand: Int, showActiveCards: Bool, maxPlayers: Int) {
        self.cardsPerHand = cardsPerHand
        self.showActiveCards = showActiveCards
        self.maxPlayers = maxPlayers
    }
    
    func encode() -> [String: Any]{
        let gameSettings: [String: Any] = [
            "cardsPerHand": cardsPerHand,
            "showActiveCards": showActiveCards,
            "maxPlayers": maxPlayers
        ]
        return gameSettings
    }
    
    func decode(from dict: [String: Any]) {
        guard let cardsPerHand = dict["cardsPerHand"] as? Int,
              let maxPlayers = dict["maxPlayers"] as? Int,
              let showActiveCards = dict["showActiveCards"] as? Bool else {
                  print("Invalid Game")
            return
        }
        self.cardsPerHand = cardsPerHand
        self.maxPlayers = maxPlayers
        self.showActiveCards = showActiveCards
    }
}

extension GameSetting {
    static let defaultSettings = GameSetting(cardsPerHand: 3, showActiveCards: true, maxPlayers: 8)
}
