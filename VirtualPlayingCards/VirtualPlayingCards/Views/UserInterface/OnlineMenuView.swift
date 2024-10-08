//
//  OnlineMenuView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-08.
//

import SwiftUI

struct OnlineMenuView: View {
    @State var username : String
    var body: some View {
        TextField("Input Username", text: $username)
            .font(.title)
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 50, alignment: .center)
            .padding()
            .background(Color.white) // Set background color
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Set corner radius here
                    .stroke(Color.black, lineWidth: 2) // Border color and width
            )
            .cornerRadius(10) // This is optional if you want the entire TextField to have rounded corners
            .padding() // Add padding around the TextField
    }
}

#Preview {
    OnlineMenuView(username: "")
}
