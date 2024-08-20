//
//  VirtualPlayingCardsApp.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-18.
//

import SwiftUI

@main
struct VirtualPlayingCardsApp: App {
    var body: some Scene {
        WindowGroup {
            @State var hand = Array(Card.defaultDeck[1...7])
            CardHandView(hand: $hand)
        }
    }
}
