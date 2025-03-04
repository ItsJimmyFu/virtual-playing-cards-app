//
//  InputUsernameView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-10-08.
//

import SwiftUI

struct InputUsernameView: View {
    @State var username : String
    var body: some View {
        TextField("Input Username", text: $username)
            .font(.title)
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 50, alignment: .center)
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
            .cornerRadius(10)
            .padding()
    }
}

#Preview {
    return InputUsernameView(username: "")
}
