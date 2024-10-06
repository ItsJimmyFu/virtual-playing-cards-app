//
//  GameManager.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import Foundation
import FirebaseDatabase

class GameManager : ObservableObject, Identifiable {
    @Published var gameCode: String
    @Published var history: [GameState]
    @Published var settings: GameSetting
    @Published var ref: DatabaseReference?
    @Published var currentGameState : GameState
    var loadedData : Bool

    init(currentGame: GameState, settings: GameSetting) {
        //Create a random gamecode
        self.gameCode = String(format: "%04d", Int.random(in: 0...9999))
        self.history = [currentGame]
        self.currentGameState = currentGame
        self.settings = settings
        self.loadedData = true
        self.ref = Database.database().reference()
    }
    
    init(gamecode: String) async throws{
        self.ref = Database.database().reference()
        self.gameCode = gamecode
        self.history = []
        self.settings = GameSetting(cardsPerHand: 0, showActiveCards: false)
        self.currentGameState = GameState(name: "", players: [], deck: [], turn: -1)
        self.loadedData = false
        Task {
            do {
                try await self.fetchItems()
                print("Data Loaded successfully!")
                self.loadedData = true
            } catch {
                print("Error saving data: \(error)")
            }
        }
    }
    
    func reinit(gamecode: String) async throws {
        print("REINIT:" + gamecode)
        self.ref = Database.database().reference()
        self.gameCode = gamecode
        self.history = []
        self.settings = GameSetting(cardsPerHand: 0, showActiveCards: false)
        self.currentGameState = GameState(name: "", players: [], deck: [], turn: -1)
        self.loadedData = false
        Task {
            do {
                try await self.fetchItems()
                print("Data Loaded successfully!")
                self.loadedData = true
            } catch {
                print("Error saving data: \(error)")
            }
        }
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
        let newGameState : GameState = currentGameState.copy() as! GameState
        
        let newCard : Card = newGameState.deck.popLast()!
        newCard.player = newGameState.players[newGameState.turn]
        newGameState.players[newGameState.turn].hand.append(newCard)
        
        nextGameState(newGameState: newGameState)
    }
    
    //Move to the next turn in the game state
    func nextTurn(){
        let newGameState : GameState = currentGameState.copy() as! GameState
        
        newGameState.turn = (newGameState.turn + 1) % newGameState.players.count
        
        nextGameState(newGameState: newGameState)
    }
    
    func nextGameState(newGameState: GameState){
        history.append(self.currentGameState)
        self.currentGameState = newGameState
        //self.saveToDatabase()
    }
    
    func encode() -> [String: Any] {
        let gameData: [String: Any] = [
            "history": Dictionary(uniqueKeysWithValues: history.enumerated().map { (String($0.offset), $0.element.encode()) }),
            //"history": history.map {$0.encode() }),
            "current_game_state": currentGameState.encode(),
            "settings": settings.encode()
        ]
        return gameData
    }
    
    func decode(from dict: [String: Any]) {
        guard let history = dict["history"] as? [Any],
              let curGameState = dict["current_game_state"] as? [String:Any],
              let settings = dict["settings"] as? [String:Any] else {
                  print("Invalid GameManager")
            return  // Return nil if any required field is missing
        }
        self.history = []
        
        for gameState in history {
            let newGameState : GameState = GameState.emptyGame
            newGameState.decode(from: gameState as! [String : Any])
            self.history.append(newGameState)
        }
        
        self.settings.decode(from: settings)
        print("Starting decode ")
        self.currentGameState.decode(from: curGameState)
        print("START")
        for card in self.currentGameState.deck {
            print(card.suit + " " + card.rank)
        }
        print("MIDDLE")
        for card in self.currentGameState.players[0].hand {
            print(card.suit + " " + card.rank)
        }
        print("END")
    }
    
    //Save the game to the database
    func saveToDatabase() {
        ref?.child("games").child(gameCode).setValue(self.encode()) { error, _ in
            if let error = error {
                print("Error saving user to database: \(error.localizedDescription)")
            } else {
                print("Game saved successfully!")
            }
        }
    }
    
    func fetchItems() async throws {
        print("Fetching")
        // Observe changes in the "items" node
        return try await withCheckedThrowingContinuation { continuation in
            //ref?.child("games").child(gameCode).observe(.value) { snapshot in
            ref?.child("games").child(gameCode).observeSingleEvent(of: .value) { snapshot in
                guard snapshot.value is [String: Any] else {
                    continuation.resume()
                    return
                }
                self.decode(from: snapshot.value as! [String : Any])
                continuation.resume()
            } withCancel: { error in
                // Handle the error case
                continuation.resume(throwing: error)
            }
        }
    }

    /*
    func updateItem(item: Item) {
        let itemRef = ref.child("items").child(item.id)
        do {
            try itemRef.setValue(["name": item.name, "value": item.value])
        } catch {
            print("Error updating item: \(error)")
        }
    }
     */
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
