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
    @Published var activeCards : [[Card]]
    
    init(id: UUID = UUID(), name: String, players: [Player], deck: [Card], turn : Int, activeCards: [[Card]]) {
        self.id = id
        self.name = name
        self.players = players
        self.deck = deck
        self.turn = turn
        self.activeCards = activeCards
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return GameState(name: self.name, players: self.players, deck: self.deck, turn: self.turn, activeCards: self.activeCards)
    }
    
    //Get the next player who will be playing the next turn
    func getNextPlayer() -> Player {
        return players[(turn + 1) % players.count]
    }
    
    func encode() -> [String: Any] {
        let gameState : [String: Any] = [
            "name": name,
            "players": players.map { $0.encode()},
            "deck": deck.map {$0.encode()},
            "turn": turn,
            "activeCards" : activeCards.map { activeCard in
                activeCard.map { element in
                    element.encode()
                }
            }
        ]
        return gameState
    }
    
    func decode(from dict: [String: Any]) {
        guard let name = dict["name"] as? String,
              let players = dict["players"] as? [Any],
              let deck = dict["deck"] as? [Any],
              let turn = dict["turn"] as? Int,
              let activeCards = dict["activeCards"] as? [[Any]] else {
              
            print("Invalid GameState")
            return
        }
        self.name = name
        self.players = []
        for player in players {
            let newPlayer : Player = Player(name: "", turn: -1, hand: [], color: .black)
            newPlayer.decode(from: player as! [String : Any])
            self.players.append(newPlayer)
        }
        self.deck = []
        for card in deck {
            guard let newCard = Card.decode(from: card as! [String : Any]) else {
                    print("Invalid Card")
                    return
            }
            self.deck.append(newCard)
        }
        self.turn = turn
        self.activeCards = []
        for activeCard in activeCards {
            var newActiveCard : [Card] = []
            for card in activeCard {
                guard let newCard = Card.decode(from: card as! [String : Any]) else {
                        print("Invalid Card")
                        return
                }
                newActiveCard.append(newCard)
            }
            self.activeCards.append(newActiveCard)
        }
    }
}

//Create custom variables to be used in preview and default Game settings
extension GameState {
    static let emptyGame: GameState = GameState(name: "", players: [], deck: [], turn: 0, activeCards: [])
}
