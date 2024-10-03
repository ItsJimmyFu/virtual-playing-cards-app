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
    
}

extension GameSetting {
    static let defaultSettings = GameSetting(cardsPerHand: 3, showActiveCards: true)
}
