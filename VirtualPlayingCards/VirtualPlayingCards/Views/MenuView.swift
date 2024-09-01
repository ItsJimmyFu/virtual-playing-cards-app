//
//  MenuView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("back")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("Virtual Playing Cards")
                    .font(.largeTitle)
                    .padding()
                NavigationLink(destination: GameView()) {
                    Text("Start Local Game")
                        .font(.title)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                Text("Start Online Game")
                    .font(.title)
                    .padding()
                Text("Start Online Game")
                    .font(.title)
                    .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    MenuView()
}
