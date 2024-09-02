//
//  Game.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import Foundation

struct Game : Identifiable {
    let id: UUID
    var name: String
    var players : [Player]
    var cardsPerHand : Int
    var deck : [Card]
    var turn : Int
    
    init(id: UUID = UUID(), name: String, players: [Player], cardsPerHand: Int, deck: [Card], turn : Int) {
        self.id = id
        self.name = name
        self.players = players
        self.cardsPerHand = cardsPerHand
        self.deck = deck
        self.turn = turn
    }
    
    mutating func dealHand(){
        /*
        //Checking if cardsPerHand exceeds the possible number of cards in deck
        if((cardsPerHand * players.count) < deck.count) {
            cardsPerHand = deck.count / players.count
        }
        */
        for player in players {
            let hand : [Card] = Array(deck.prefix(cardsPerHand))
            for card in hand {
                card.player = player
            }
            player.hand = hand
            deck = Array(deck.dropFirst(cardsPerHand))
        }
    }
}

extension Game {
    static let emptyGame: Game = Game(name: "", players: [], cardsPerHand: 0, deck: [], turn: 0)
    static let sampleGame: Game = Game(name: "Sample Game", players: Player.gamePlayers, cardsPerHand: 5, deck: Card.defaultDeck, turn: 0)
    
}
