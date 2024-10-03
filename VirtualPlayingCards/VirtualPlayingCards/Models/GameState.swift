//
//  Game.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import Foundation

//Represents a State of the Game
class GameState : NSObject, NSCopying, Identifiable, ObservableObject {

    let id: UUID
    var name: String
    @Published var players : [Player]
    @Published var deck : [Card]
    @Published var turn : Int
    
    init(id: UUID = UUID(), name: String, players: [Player], deck: [Card], turn : Int) {
        self.id = id
        self.name = name
        self.players = players
        self.deck = deck
        self.turn = turn
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return GameState(name: self.name, players: self.players, deck: self.deck, turn: self.turn)
    }
    
    //Get the next player who will be playing the next turn
    func getNextPlayer() -> Player {
        return players[(turn + 1) % players.count]
    }
}

//Create custom variables to be used in preview and default Game settings
extension GameState {
    static let emptyGame: GameState = GameState(name: "", players: [], deck: [], turn: 0)
}
