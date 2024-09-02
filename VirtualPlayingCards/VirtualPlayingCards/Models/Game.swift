//
//  Game.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import Foundation

class Game : Identifiable, ObservableObject {
    let id: UUID
    var name: String
    @Published var players : [Player]
    @Published var cardsPerHand : Int
    @Published var deck : [Card]
    @Published var turn : Int
    
    init(id: UUID = UUID(), name: String, players: [Player], cardsPerHand: Int, deck: [Card], turn : Int) {
        self.id = id
        self.name = name
        self.players = players
        self.cardsPerHand = cardsPerHand
        self.deck = deck
        self.turn = turn
    }
    
    func dealHand(){
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
    
    func nextTurn(){
        turn = (turn + 1) % players.count
    }
    
    func getNextPlayer() -> Player {
        return players[(turn + 1) % players.count]
    }
}

extension Game {
    static let emptyGame: Game = Game(name: "", players: [], cardsPerHand: 0, deck: [], turn: 0)
    static let sampleGame: Game = {
        var game = Game(name: "Sample Game", players: Player.gamePlayers, cardsPerHand: 5, deck: Card.defaultDeck, turn: 0)
        game.deck.shuffle()
        game.dealHand()
        return game
    }()
}
