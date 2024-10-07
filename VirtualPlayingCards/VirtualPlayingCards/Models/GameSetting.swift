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
    
    init(cardsPerHand: Int, showActiveCards: Bool) {
        self.cardsPerHand = cardsPerHand
        self.showActiveCards = showActiveCards
    }
    
    func encode() -> [String: Any]{
        let gameSettings: [String: Any] = [
            "cardsPerHand": cardsPerHand,
            "showActiveCards": showActiveCards
        ]
        return gameSettings
    }
    
    func decode(from dict: [String: Any]) {
        guard let cardsPerHand = dict["cardsPerHand"] as? Int,
              let showActiveCards = dict["showActiveCards"] as? Bool else {
                  print("Invalid Game")
            return
        }
        self.cardsPerHand = cardsPerHand
        self.showActiveCards = showActiveCards
    }
}

extension GameSetting {
    static let defaultSettings = GameSetting(cardsPerHand: 3, showActiveCards: true)
}
