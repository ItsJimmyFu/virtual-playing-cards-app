//
//  Card.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-19.
//

import Foundation

struct Card: Identifiable {
    let id: UUID
    let suit: String
    let rank: String
    let imagePath: String
   
    
    init(id: UUID = UUID(), suit: String, rank: String){
        self.id = id
        self.suit = suit
        self.rank = rank
        
        if(self.suit == "joker"){
            self.imagePath = self.suit + "_" + self.rank
        }
        else {
            self.imagePath = self.rank + "_of_" + self.suit
        }
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
        cards.append(Card(suit: "joker", rank: "red"))
        cards.append(Card(suit: "joker", rank: "black"))

        return cards
    }()
}
