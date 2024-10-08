//
//  MenuView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-01.
//

import SwiftUI

struct MenuView: View {
    @State private var isPresentingHostSettingView = false
    @State private var isPresentingJoinView = false
    @State private var isPresentingLocalSettingView = false
    
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
                Text("Cards with Friends")
                    .font(.largeTitle)
                    .padding(30)
                    .background(Color.black)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .padding(.vertical)
                
                Button(action: {
                    isPresentingLocalSettingView = true
                }, label: {
                    Text("Local Game")
                        .font(.title)
                })
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding(.vertical)
                
                Button(action: {
                    isPresentingHostSettingView = true
                }, label: {
                    Text("Host Game")
                        .font(.title)
                })
                .padding()
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(10)
                Button(action: {
                    isPresentingJoinView = true
                }, label: {
                    Text("Join Game")
                        .font(.title)
                })
                .padding()
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.vertical)
                Spacer()
            }
        }
        .sheet(isPresented: $isPresentingJoinView) {
            NavigationStack {
                JoinView()
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("Back"){
                                isPresentingJoinView = false
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $isPresentingLocalSettingView) {
            NavigationStack {
                SettingsView(isOnline: false)
                    .navigationTitle("Menu")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("Back"){
                                isPresentingLocalSettingView = false
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $isPresentingHostSettingView) {
            NavigationStack {
                SettingsView(isOnline: true)
                    .navigationTitle("Menu")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("Back"){
                                isPresentingHostSettingView = false
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
