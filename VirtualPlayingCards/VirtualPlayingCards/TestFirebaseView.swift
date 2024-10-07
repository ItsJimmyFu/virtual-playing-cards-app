//
//  TestFirebaseView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import SwiftUI

struct TestFirebaseView: View {
    @State var gameCode : String = "2769"
    
    
    var body: some View {
        VStack{
            Button(action: {
                let gm : GameManager = GameManager.sampleGame
                gameCode = gm.gameCode
            }, label: {
                Text("Create New Data")
            })
            Text(gameCode)
                .padding(.bottom)
            
            TextField("Gamecode", text: $gameCode)
            Button(action: {
                Task {
                    let _ : GameManager = GameManager(gamecode: gameCode)
                }
            }, label: {
                Text("Load Data")
            })
            Text(gameCode)
        }
    }
}

#Preview {
    TestFirebaseView()
}
