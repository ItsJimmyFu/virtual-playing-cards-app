//
//  Game.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import Foundation

//Represents a State of the Game
class Game : Identifiable, ObservableObject {
    let id: UUID
    var name: String
    @Published var players : [Player]
    @Published var cardsPerHand : Int
    @Published var deck : [Card]
    @Published var turn : Int
    @Published var showActiveCards : Bool = false
    
    init(id: UUID = UUID(), name: String, players: [Player], cardsPerHand: Int, deck: [Card], turn : Int) {
        self.id = id
        self.name = name
        self.players = players
        self.cardsPerHand = cardsPerHand
        self.deck = deck
        self.turn = turn
    }
    
    //Deals cards from deck to all the players equally based on the cardsPerHand
    func dealHand(){
        for player in players {
            let hand : [Card] = Array(deck.prefix(cardsPerHand))
            for card in hand {
                card.player = player
            }
            player.hand = hand
            deck = Array(deck.dropFirst(cardsPerHand))
        }
    }
    
    //Draw a card for the current player in a turn
    func drawCard(){
        let newCard : Card = deck.popLast()!
        newCard.player = players[turn]
        players[turn].hand.append(newCard)
    }
    
    //Move to the nex turn in the game state
    func nextTurn(){
        turn = (turn + 1) % players.count
    }
    
    //Get the next player who will be playing the next turn
    func getNextPlayer() -> Player {
        return players[(turn + 1) % players.count]
    }
}

//Create custom variables to be used in preview and default Game settings
extension Game {
    static let emptyGame: Game = Game(name: "", players: [], cardsPerHand: 0, deck: [], turn: 0)
    static let sampleGame: Game = {
        var game = Game(name: "Sample Game", players: Player.gamePlayers, cardsPerHand: 5, deck: Card.defaultDeck, turn: 0)
        game.deck.shuffle()
        game.dealHand()
        return game
    }()
}
