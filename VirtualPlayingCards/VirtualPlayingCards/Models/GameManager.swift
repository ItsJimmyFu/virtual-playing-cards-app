//
//  GameManager.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import Foundation
import FirebaseDatabase

class GameManager : ObservableObject, Identifiable {
    let gameCode: String
    @Published var history: [GameState]
    @Published var settings: GameSetting
    @Published var ref: DatabaseReference?
    @Published var currentGameState : GameState

    init(currentGame: GameState, settings: GameSetting) {
        self.gameCode = String(format: "%04d", Int.random(in: 0...9999))
        self.history = [currentGame]
        self.currentGameState = currentGame
        self.settings = settings
        
        self.ref = Database.database().reference()
        self.saveToDatabase()
    }
    
    //Deals cards from deck to all the players equally based on the cardsPerHand
    func dealHand(){
        for player in currentGameState.players {
            let hand : [Card] = Array(currentGameState.deck.prefix(settings.cardsPerHand))
            for card in hand {
                card.player = player
            }
            player.hand = hand
            currentGameState.deck = Array(currentGameState.deck.dropFirst(settings.cardsPerHand))
        }
    }
    
    //Draw a card for the current player in a turn
    func drawCard(){
        var newGameState : GameState = currentGameState.copy() as! GameState
        
        let newCard : Card = newGameState.deck.popLast()!
        newCard.player = newGameState.players[newGameState.turn]
        newGameState.players[newGameState.turn].hand.append(newCard)
        
        nextGameState(newGameState: newGameState)
    }
    
    //Move to the next turn in the game state
    func nextTurn(){
        var newGameState : GameState = currentGameState.copy() as! GameState
        
        newGameState.turn = (newGameState.turn + 1) % newGameState.players.count
        
        nextGameState(newGameState: newGameState)
    }
    
    func nextGameState(newGameState: GameState){
        history.append(self.currentGameState)
        self.currentGameState = newGameState
    }
    
    func encode() -> [String: Any] {
        let gameData: [String: Any] = [
            "history": ["GameState":123],
            "settings": "abcd"
        ]
        return gameData
    }
    
    //Save the game to the database
    func saveToDatabase() {
        ref?.child("games").child(gameCode).setValue(self.encode()) { error, _ in
            if let error = error {
                print("Error saving user to database: \(error.localizedDescription)")
            } else {
                print("User saved successfully!")
            }
        }
    }
}

//Create custom variables to be used in preview and default Game settings
extension GameManager {
    static let emptyGame: GameManager = GameManager(currentGame: GameState.emptyGame, settings: GameSetting.defaultSettings)
    static let sampleGame = {
        var game = GameManager(currentGame: GameState(name: "Sample Game", players: Player.gamePlayers, deck: Card.defaultDeck, turn: 0), settings: GameSetting.defaultSettings)
        game.currentGameState.deck.shuffle()
        game.dealHand()
        return game
    }()
}
