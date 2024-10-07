//
//  JoinView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-03.
//

import SwiftUI

struct JoinView: View {
    @StateObject var game : GameManager = GameManager.emptyGame
    @State var gameCode: String = ""
    @FocusState private var isFocused: Bool
    @State var isGameViewActive : Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            Text("Input Game Code")
                .font(.title)
            ZStack {
                // Invisible TextField
                TextField("", text: $gameCode)
                    .onChange(of: gameCode) { _, newValue in
                        // Limit the input to 4 digits and ensure it only contains numbers
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered.count > 4 {
                            gameCode = String(filtered.prefix(4))
                        } else {
                            gameCode = filtered
                        }
                    }
                    .keyboardType(.numberPad) // Show number pad for input
                    .padding()
                    .background(Color.clear)
                    .frame(width: 200, height: 50)
                    .opacity(0)
                    .focused($isFocused)
                 
                HStack {
                    ForEach(0..<4, id: \.self) { index in
                        
                        let digit : String = index < gameCode.count ? String(gameCode[gameCode.index(gameCode.startIndex, offsetBy: index)]) : " "
                        ZStack {
                            Text(String(digit))
                                .frame(width:50,height: 150)
                                .padding() // Padding inside the text field
                                .background(Color.white) // Background color of the text field
                                .cornerRadius(10) // Rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Rounded rectangle for the border
                                        .stroke(Color.black, lineWidth: 2)
                                )
                                .multilineTextAlignment(.center)
                                .font(.system(size: 54))
                                .padding(.vertical)
                            if(index-1 < gameCode.count){
                                Rectangle()
                                    .frame(width:60, height: 2)
                                    .foregroundColor(.black)
                                    .offset(CGSize(width: 0, height: 40.0))
                            }
                        }
                    }
                }
            }
            
            Spacer()
            Button(action: {
                //MAKE BUTTON SHAKE
                if(gameCode.count == 4){
                    game.reinit(gamecode: gameCode)
                    isGameViewActive = true
                }
            }, label: {
                Text("Join Game")
                    .font(.title)
            })
            .foregroundColor(.black)
            .padding()
            .background(gameCode.count == 4 ? Color.green : Color.white) // Background color of the text field
            .cornerRadius(10) // Rounded corners
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded rectangle for the border
                .stroke(Color.black, lineWidth: 2) // Border color and width
            )
            Spacer()
        }
        .onAppear {
            // Automatically focus on the TextField when the view appears
            isFocused = true
        }
        .fullScreenCover(isPresented: .init(
            get: { game.loadedData && isGameViewActive }, // Check if both are true
            set: { _ in } // No setter needed
        )) {
            GameView(gameManager: game)
        }
    }
}

#Preview {
    JoinView()
}
