//
//  AdvancedSettingSection.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-12.
//

import SwiftUI

struct AdvancedSettingSection: View {
    @Binding var showActiveCards: Bool
    
    var body: some View {
        //TODO Add DisclosureGroup
        Section(header: Text("Advanced Settings")) {
            HStack {
                Text("Cards in Play Face Down")
                Spacer()
                
                Button(action: {
                    showActiveCards.toggle()
                }, label: {
                    Image(systemName: showActiveCards ? "checkmark.square" : "square")
                        .font(.title)
                        .foregroundColor(showActiveCards ? .blue : .gray)
                })
            }
        }

    }
}

#Preview {
    @State var game : GameManager = GameManager.sampleGame
    return Form {
        AdvancedSettingSection(showActiveCards: $game.settings.showActiveCards)
    }
}
