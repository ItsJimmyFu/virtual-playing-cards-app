//
//  GameManager.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import Foundation
import FirebaseDatabase

class GameManager : ObservableObject {
    let gameCode: String
    var history: [GameState]
    var settings: GameSetting
    var ref: DatabaseReference?

    init(currentGame: GameState, settings: GameSetting) {
        self.gameCode = String(format: "%04d", Int.random(in: 0...9999))
        self.history = [currentGame]
        self.settings = settings
        
        self.ref = Database.database().reference()
        self.saveToDatabase()
    }
    
    func encode() -> [String: Any] {
        let gameManagerData: [String: Any] = [
            "history": 123,
            "settings": "abcd"
        ]
        return gameManagerData
    }
    
    func saveToDatabase() {
        // Push a new user to the "games" node
        ref?.child("games").child(gameCode).setValue(self.encode()) { error, _ in
            if let error = error {
                print("Error saving user to database: \(error.localizedDescription)")
            } else {
                print("User saved successfully!")
            }
        }
    }
}
