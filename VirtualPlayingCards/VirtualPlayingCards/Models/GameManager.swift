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
    var isLocal: Bool
    var loadedData : Bool
    @Published var playerId : UUID?
    var started: Bool = false

    init(currentGame: GameState, settings: GameSetting) {
        //Create a random gamecode
        self.gameCode = String(format: "%04d", Int.random(in: 0...9999))
        self.history = [currentGame]
        self.currentGameState = currentGame
        self.settings = settings
        self.loadedData = true
        self.ref = nil
        self.isLocal = true
        self.playerId = nil
    }
    
    func startOnline(playerId: UUID){
        self.isLocal = false
        self.loadedData = false
        self.playerId = playerId
        self.ref = Database.database().reference()
        self.saveToDatabase()
        self.fetchSingle()
        
    }
    
    func reinit(gamecode: String) {
        self.ref = Database.database().reference()
        self.gameCode = gamecode
        self.history = []
        self.settings = GameSetting(cardsPerHand: 0, showActiveCards: false)
        self.currentGameState = GameState(name: "", players: [], deck: [], turn: -1, activeCards: [])
        self.loadedData = false
        self.isLocal = false
        self.fetchSingle()
    }
    
    func start() {
        currentGameState.deck.shuffle()
        dealHand()
    }
    
    func getOnlinePlayer() -> Player{
        for player in currentGameState.players {
            if(player.id == playerId) {
                return player
            }
        }
        print("Invalid Id")
        return Player.empty
    }
    
    //Deals cards from deck to all the players equally based on the cardsPerHand
    func dealHand(){
        for player in currentGameState.players {
            let hand : [Card] = Array(currentGameState.deck.prefix(settings.cardsPerHand))
            player.hand = hand
            currentGameState.deck = Array(currentGameState.deck.dropFirst(settings.cardsPerHand))
        }
    }
    
    //Draw a card for the current player in a turn
    func drawCard(){
        let newGameState : GameState = currentGameState.copy() as! GameState
        
        let newCard : Card = newGameState.deck.popLast()!
        newGameState.players[newGameState.turn].hand.append(newCard)
        
        nextGameState(newGameState: newGameState)
    }
    
    //Play the selected cards for the current player in a turn
    func playCards(selectedCards: [Card]){
        let newGameState : GameState = currentGameState.copy() as! GameState
    
        newGameState.players[newGameState.turn].hand = currentGameState.players[currentGameState.turn].hand.filter { !selectedCards.contains($0)}
        
        //Remove the most recent move from the player
        if(newGameState.activeCards.count > 0 && newGameState.activeCards[0].0 == newGameState.players[newGameState.turn]){
            newGameState.activeCards.remove(at: 0)
        }
        //Add the new move
        if(selectedCards.count > 0) {
            newGameState.activeCards.append((newGameState.players[newGameState.turn],selectedCards))
        }
        newGameState.turn = (newGameState.turn + 1) % newGameState.players.count
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
        if(!self.isLocal){
            self.saveToDatabase()
        }
    }
    
    func prevGameState(){
        if(history.count > 0){
            currentGameState = history.popLast()!
        }
        if(!self.isLocal) {
            self.saveToDatabase()
        }
    }
    
    func encode() -> [String: Any] {
        let gameData: [String: Any] = [
            "history": Dictionary(uniqueKeysWithValues: history.enumerated().map { (String($0.offset), $0.element.encode()) }),
            //"history": history.map {$0.encode() }),
            "current_game_state": currentGameState.encode(),
            "settings": settings.encode(),
            "isStarted" : started
        ]
        return gameData
    }
    
    func decode(from dict: [String: Any]) {
        guard let history = dict["history"] as? [Any],
              let curGameState = dict["current_game_state"] as? [String:Any],
              let settings = dict["settings"] as? [String:Any],
              let started = dict["isStarted"] as? Bool else {
                  print("Invalid GameManager")
            return  // Return nil if any required field is missing
        }
        self.started = started
        self.history = []
        
        for gameState in history {
            let newGameState : GameState = GameState.emptyGame
            newGameState.decode(from: gameState as! [String : Any])
            self.history.append(newGameState)
        }
        self.settings.decode(from: settings)
        self.currentGameState.decode(from: curGameState)
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
    
    func fetchSingle() {
        // Observe changes in the "items" node
        ref?.child("games").child(gameCode).observe(.value) { snapshot in
            self.decode(from: snapshot.value as! [String : Any])
            self.loadedData = true
        }
    }
}

//Create custom variables to be used in preview and default Game settings
extension GameManager {
    static let emptyGame: GameManager = GameManager(currentGame: GameState.emptyGame, settings: GameSetting.defaultSettings)
    static let sampleGame = {
        var game = GameManager(currentGame: GameState(name: "Sample Game", players: Player.gamePlayers, deck: Card.defaultDeck, turn: 0, activeCards: [(Player.gamePlayers[0], [Card(suit:"diamonds", rank: "2"), Card(suit:"hearts", rank: "2"), Card(suit: "clubs", rank: "2")])]), settings: GameSetting.defaultSettings)
        game.currentGameState.deck.shuffle()
        game.dealHand()
        return game
    }()
}
