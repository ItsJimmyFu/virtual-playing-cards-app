//
//  Card.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-19.
//

import Foundation

// Represents a Playing Card with Suit or Rank
class Card: Identifiable, Equatable {
    let id: UUID
    //Suit of the card: Hearts, Spades, Diamonds, Clubs, (Red or Black for Joker)
    var suit: String
    
    //Rank of the card: Ace, 2 - 10, Jack, Queen, King, Joker
    var rank: String
    var imagePath: String
    var player: Player?
    var selected: Bool
    
    //Initalize a new card with the given Suit and Rank
    init(id: UUID = UUID(), suit: String, rank: String){
        self.id = id
        self.suit = suit
        self.rank = rank
        
        //Check for a special case if initializing a joker card
        if(self.rank == "joker"){
            self.imagePath = self.suit + "_" + self.rank
        }
        else {
            self.imagePath = self.rank + "_of_" + self.suit
        }
        self.player = nil
        self.selected = false
    }
    
    //Initializes a new card with given Suit and Rank and the Player holding the card
    init(id: UUID = UUID(), suit: String, rank: String, player: Player){
        self.id = id
        self.suit = suit
        self.rank = rank
        
        //Check for a special case if initializing a joker card
        if(self.rank == "joker"){
            self.imagePath = self.suit + "_" + self.rank
        }
        else {
            self.imagePath = self.rank + "_of_" + self.suit
        }
        self.player = player
        self.selected = true
    }
    
    //Check if two cards are the same
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    }
    
    func encode() -> [String: Any] {
        return ["suit": suit, "rank": rank]
    }
    
    static func decode(from dict: [String: Any]) -> Card? {
        guard let rank = dict["rank"] as? String,
              let suit = dict["suit"] as? String else {
            print("Invalid Card")
            return nil
        }
        return Card(suit: suit, rank: rank)
    }
}

//Create custom variables to be used in preview and default card settings
extension Card {
    static let empty: Card = Card(suit: "", rank: "")
    
    static let defaultDeck: [Card] = {
        var cards: [Card] = []
        var ranks: [String] = ["ace","2","3","4","5","6","7","8","9","10","jack","queen","king"]
        var suits: [String] = ["hearts","spades","diamonds","clubs"]
        for suit in suits {
            for rank in ranks {
                let card = Card(suit: suit, rank: rank)
                cards.append(card)
            }
        }
        
        cards.append(Card(suit: "red", rank: "joker"))
        cards.append(Card(suit: "black", rank: "joker"))
        
        return cards
    }()
    
    static let sampleHand: [Card] = [
        Card(suit: "hearts", rank: "ace"),
        Card(suit: "diamonds", rank: "5"),
        Card(suit: "clubs", rank: "jack"),
        Card(suit: "spades", rank: "king"),
        Card(suit: "red", rank: "joker"),
        Card(suit: "hearts", rank: "9"),
        Card(suit: "spades", rank: "10")
    ]
    
    static let largeSampleHand: [Card] = [
        Card(suit: "hearts", rank: "ace"),
        Card(suit: "diamonds", rank: "5"),
        Card(suit: "clubs", rank: "jack"),
        Card(suit: "spades", rank: "king"),
        Card(suit: "red", rank: "joker"),
        Card(suit: "hearts", rank: "9"),
        Card(suit: "spades", rank: "10"),
        Card(suit: "hearts", rank: "ace"),
        Card(suit: "diamonds", rank: "5"),
        Card(suit: "clubs", rank: "jack"),
        Card(suit: "spades", rank: "king"),
        Card(suit: "red", rank: "joker"),
        Card(suit: "hearts", rank: "9"),
        Card(suit: "spades", rank: "10"),
        Card(suit: "hearts", rank: "ace"),
        Card(suit: "diamonds", rank: "5"),
        Card(suit: "clubs", rank: "jack"),
        Card(suit: "spades", rank: "king"),
        Card(suit: "red", rank: "joker"),
        Card(suit: "hearts", rank: "9"),
        Card(suit: "spades", rank: "10")
    ]
    
    static let sampleDoubleHand: [Card] = [
        Card(suit: "hearts", rank: "ace"),
        Card(suit: "diamonds", rank: "3")
    ]
    
    static let activeCards : [Card] = [
        Card(suit: "spades", rank: "3"),
        Card(suit: "diamonds", rank: "3"),
        Card(suit: "hearts", rank: "3"),
        Card(suit: "clubs", rank: "3")
    ]
}
