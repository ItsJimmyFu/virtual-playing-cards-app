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
    @Published var activeCards : [(Player,[Card])]
    
    init(id: UUID = UUID(), name: String, players: [Player], deck: [Card], turn : Int, activeCards:  [(Player,[Card])]) {
        self.id = id
        self.name = name
        self.players = players
        self.deck = deck
        self.turn = turn
        self.activeCards = activeCards
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return GameState(id: self.id, name: self.name, players: self.players.map { $0.copy() as! Player }, deck: self.deck.map { $0.copy() as! Card }, turn: self.turn, activeCards: self.activeCards.map { tuple in (tuple.0.copy() as! Player, tuple.1.map {$0.copy() as! Card} as! [Card]) })
    }
    
    //Get the next player who will be playing the next turn
    func getNextPlayer() -> Player {
        return players[(turn + 1) % players.count]
    }
    
    func getPreviousPlayer() -> Player {
        return players[(turn - 1 + players.count) % players.count]
    }
    
    func encode() -> [String: Any] {
        var activeCardMapping : [[String: Any]] = []
        for cards in activeCards {
            activeCardMapping.append(["player": cards.0.encode(), "cards": cards.1.map {$0.encode()}])
        }
        
        let gameState : [String: Any] = [
            "name": name,
            "players": players.map { $0.encode()},
            "deck": deck.map {$0.encode()},
            "turn": turn,
            "activeCards" : activeCardMapping
        ]
        return gameState
    }
    
    func decode(from dict: [String: Any]) {
        guard let name = dict["name"] as? String,
              let players = dict["players"] as? [Any],
              let deck = dict["deck"] as? [Any],
              let turn = dict["turn"] as? Int else {
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
            
        if (dict.keys.contains("activeCards")) {
            guard let activeCards = dict["activeCards"] as? [Any] else{
                print("Invalid ActiveCards")
                return
            }
            for activeCard in activeCards {
                guard let ac = activeCard as? [String:Any],
                      let player = ac["player"] as? [String:Any],
                      let cards = ac["cards"] as? [Any] else {
                    print("Invalid ActiveCards")
                    return
                }
                let newPlayer : Player = Player(name: "", turn: -1, hand: [], color: .black)
                newPlayer.decode(from: player)
                if(newPlayer.turn == -1){
                    print(newPlayer)
                }
                
                var newActiveCard : [Card] = []
                for card in cards {
                    guard let newCard = Card.decode(from: card as! [String : Any]) else {
                        print("Invalid Card")
                        return
                    }
                    newActiveCard.append(newCard)
                    
                    self.activeCards.append((newPlayer,newActiveCard))
                }
            }
        }
        else{
            print("Empty ActiveCards")
        }
    }
}

//Create custom variables to be used in preview and default Game settings
extension GameState {
    static let emptyGame: GameState = GameState(name: "", players: [], deck: [], turn: 0, activeCards: [])
}
