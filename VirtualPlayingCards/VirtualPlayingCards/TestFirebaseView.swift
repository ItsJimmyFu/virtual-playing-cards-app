//
//  TestFirebaseView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import SwiftUI

struct TestFirebaseView: View {
    @State var gameCode = ""
    
    var body: some View {
        Button(action: {
            let gm : GameManager = GameManager.sampleGame
            gameCode = gm.gameCode
        }, label: {
            Text("Create New Data")
        })
        Text(gameCode)
    }
}

#Preview {
    TestFirebaseView()
}
