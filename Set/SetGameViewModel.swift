//
//  SetGameViewModel.swift
//  Set
//
//  Created by Rahul Bir on 5/26/22.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published var setGame = SetGame(colors: ["purple", "blue", "orange"], maxNumberOfShapes: 3)
    
    typealias Card = SetGame.Card
    
    var cardsCurrentlyInGame: [Card] {
        return setGame.cardsCurrentlyInGame
    }
    
    var undealtCards: [Card] {
        return setGame.undealtCards
    }
    
    var matchedCards: [Card] {
        return setGame.matchedCards
    }
    
    static func findColorValue(_ color: String) -> Color {
        switch color {
        case "purple":
            return Color.purple
        case "blue":
            return Color.blue
        case "orange":
            return Color.orange
        default:
            return Color.gray
        }
    }
    
//    func disableButton() -> Bool { return setGame.cardsUsed >= setGame.cards.count }
    
    // MARK: - Intent(s)
    
    func choose(_ card: SetGame.Card) {
        setGame.choose(card)
    }
    
    func dealCards() {
        setGame.dealCards()
    }
    
//    func newGame() {
//        setGame.newGame()
//    }
//
//    func deal3Cards() {
//        setGame.deal3Cards()
//    }
}
