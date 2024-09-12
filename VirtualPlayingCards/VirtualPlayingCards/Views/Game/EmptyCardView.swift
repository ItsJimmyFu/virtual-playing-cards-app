//
//  EmptyCardView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-08-28.
//

import SwiftUI

//Display for an empty view of cards
struct EmptyCardView: View {
    @State var cardWidth : CGFloat
    var body: some View {
        Image("back")
            .resizable()
            .scaledToFit()
            .frame(width: cardWidth)
            .overlay(
                Rectangle()
                    .foregroundColor(.white)
            )
            .border(Color.black,width:0.5)
    }
}

#Preview {
    EmptyCardView(cardWidth: 200)
}
