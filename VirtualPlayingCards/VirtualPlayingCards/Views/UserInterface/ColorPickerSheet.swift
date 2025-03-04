//
//  ColorPickerView.swift
//  VirtualPlayingCards
//
//  Created by Jimmy Fu on 2024-09-04.
//

import SwiftUI

struct ColorPickerSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedColor : Color
    @State var colors: [ColorOption] = ColorOption.colors
    
    var body: some View {
        LazyHGrid(rows: Array(repeating: GridItem(), count: 2), content: {
            ForEach(colors) { color in
                Image(systemName: selectedColor == color.color ? "circle.circle.fill" : "circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(color.color)
                    .opacity(0.8)
                    .overlay{
                       Circle()
                           .stroke(lineWidth: 3)
                           .foregroundColor(selectedColor == color.color ? .white : .clear)
                    }
                    .onTapGesture {
                       withAnimation{
                           selectedColor = color.color
                           dismiss()
                       }
                    }
            }
        })
        .frame(height: 100)
    }
}

#Preview {
    @State var player : Player = Player.curPlayer
    return ColorPickerSheet(selectedColor: $player.color)
}
