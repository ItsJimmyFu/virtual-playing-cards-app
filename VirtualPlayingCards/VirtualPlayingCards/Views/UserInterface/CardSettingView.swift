//
//  CardSettingView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-02.
//

import SwiftUI

struct CardSettingView: View {
    @Binding var deck : [Card]
    @Binding var selected : [Card]
    
    let columns = [
            GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(deck.indices, id: \.self ) {index in
                        VStack {
                            Button (action: {
                                if(selected.contains(deck[index])){
                                    selected.removeAll { $0 == deck[index] }
                                }
                                else{
                                    selected.append(deck[index])
                                }
                       
                            }, label: {
                                Image(deck[index].imagePath)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width/5)
                                    .border(Color.black)
                                    .background(selected.contains(deck[index]) ? Color.gray.opacity(0.3) : Color.clear)
                            })
                        
                            Image(systemName: selected.contains(deck[index]) ? "circle.circle.fill" : "circle")
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    @State var deck : [Card] = Card.defaultDeck
    @State var selected: [Card] = [deck[0]]
    return CardSettingView(deck: $deck, selected: $selected)
}
