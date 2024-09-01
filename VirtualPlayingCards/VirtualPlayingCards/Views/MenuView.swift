//
//  MenuView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import SwiftUI

struct MenuView: View {
    @State private var isPresentingSettingView = false
    
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
                Button(action: {
                    isPresentingSettingView = true
                }, label: {
                    Text("Local")
                        .font(.title)
                })
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                Text("Online")
                    .font(.title)
                    .padding()
                Spacer()
            }
        }
        .sheet(isPresented: $isPresentingSettingView){
            NavigationStack {
                SettingsView()
                    .navigationTitle("Menu")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("Back"){
                                isPresentingSettingView = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    MenuView()
}
