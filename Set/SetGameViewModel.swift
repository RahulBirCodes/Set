//
//  SetGameViewModel.swift
//  Set
//
//  Created by Rahul Bir on 5/26/22.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published var setGame = SetGame(colors: ["purple", "blue", "pink"], maxNumberOfShapes: 3)
    
    var cards: [SetGame.Card] {
        return setGame.cards
    }
    
    static func findColorValue(_ color: String) -> Color {
        switch color {
        case "purple":
            return Color.purple
        case "blue":
            return Color.blue
        case "pink":
            return Color.pink
        default:
            return Color.red
        }
    }
}
