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
    @State private var isOnline = false
    @State var username : String = ""
    
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
                if(isOnline) {
                    TextField("Username", text: $username)
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
                    
                    Button(action: {
                        if(username.count > 0){
                            print("Menu:" + username)
                            isPresentingHostSettingView = true
                        }
                    }, label: {
                        Text("Host Game")
                            .font(.title)
                    })
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    Button(action: {
                        if(username.count > 0) {
                            isPresentingJoinView = true
                        }
                    }, label: {
                        Text("Join Game")
                            .font(.title)
                    })
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding(.vertical)
                    Button(action: {
                        isOnline = false
                    }, label: {
                        Text("Back")
                            .font(.title3)
                    })
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                }
                else {
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
                    Button(action: {
                        isOnline = true
                    }, label: {
                        Text("Online Game")
                            .font(.title)
                    })
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding(.vertical)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $isPresentingJoinView) {
            NavigationStack {
                JoinView(username: username)
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
                SettingsView(isOnline: true, username: username)
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
