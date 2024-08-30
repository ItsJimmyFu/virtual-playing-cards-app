//
//  Card.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-19.
//

import Foundation

struct Card: Identifiable, Equatable {
    let id: UUID
    let suit: String
    let rank: String
    let imagePath: String
    let player: Player?
    
    init(id: UUID = UUID(), suit: String, rank: String){
        self.id = id
        self.suit = suit
        self.rank = rank
        
        if(self.rank == "joker"){
            self.imagePath = self.suit + "_" + self.rank
        }
        else {
            self.imagePath = self.rank + "_of_" + self.suit
        }
        self.player = nil
    }
    
    init(id: UUID = UUID(), suit: String, rank: String, player: Player){
        self.id = id
        self.suit = suit
        self.rank = rank
        
        if(self.rank == "joker"){
            self.imagePath = self.suit + "_" + self.rank
        }
        else {
            self.imagePath = self.rank + "_of_" + self.suit
        }
        self.player = player
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Card {
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
