//
//  SetGame.swift
//  Set
//
//  Created by Rahul Bir on 5/26/22.
//

import Foundation

struct SetGame {
    
    private var deckTemplate: [Card]
    private(set) var undealtCards: [Card]
    private(set) var cardsCurrentlyInGame: [Card]
    private(set) var matchedCards: [Card]

    private(set) var colors: [String]
    private(set) var match: Bool?
    
    private var selectedCardsIndices: [Int] {
        get { cardsCurrentlyInGame.indices.filter({ cardsCurrentlyInGame[$0].isChosen }) }
        set { cardsCurrentlyInGame.indices.forEach({ cardsCurrentlyInGame[$0].isChosen = newValue.contains($0) }) }
    }
    
    init(colors: [String], maxNumberOfShapes: Int) {
        deckTemplate = []
        self.colors = colors
        
        for num in 1...maxNumberOfShapes {
            for shape in Card.Shape.allCases {
                for fill in Card.Fill.allCases {
                    for color in colors {
                        deckTemplate.append(Card(number: num, shape: shape, fill: fill, color: color, id: UUID().uuidString))
                    }
                }
            }
        }
        undealtCards = deckTemplate.shuffled()
        cardsCurrentlyInGame = []
        matchedCards = []
    }
    
    mutating func dealCards() {
        if !undealtCards.isEmpty {
            var numOfCardsToAdd = 0
            if cardsCurrentlyInGame.isEmpty {
                numOfCardsToAdd = 12
            } else {
                numOfCardsToAdd = (undealtCards.count >= 3) ? 3 : undealtCards.count
            }
            cardsCurrentlyInGame.append(contentsOf: undealtCards[0..<numOfCardsToAdd])
            undealtCards.removeFirst(numOfCardsToAdd)
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cardsCurrentlyInGame.firstIndex(where: { $0.id == card.id }) {
            match = nil
            // Deselect card
            if cardsCurrentlyInGame[chosenIndex].isChosen {
                cardsCurrentlyInGame[chosenIndex].isChosen = false
            } else {
                if selectedCardsIndices.count == 3 {
                    selectedCardsIndices = []
                }
                cardsCurrentlyInGame[chosenIndex].isChosen = true
                if selectedCardsIndices.count == 3 {
                    match = checkMatch(for: selectedCardsIndices.map({ cardsCurrentlyInGame[$0] }))
                    if match! {
                        selectedCardsIndices.forEach {
                            cardsCurrentlyInGame[$0].matched = true
                            cardsCurrentlyInGame[$0].isChosen = false
                        }
                        let matched = cardsCurrentlyInGame.filter({ $0.matched })
                        cardsCurrentlyInGame.removeAll(where: { $0.matched })
                        matchedCards.append(contentsOf: matched)
                    }
                }
            }
        }
    }
    
    private func checkMatch(for cards: [Card]) -> Bool {
        let sameShapes = compareThreeElements(cards[0].shape, cards[1].shape, cards[2].shape)
        let sameNum = compareThreeElements(cards[0].number, cards[1].number, cards[2].number)
        let sameFill = compareThreeElements(cards[0].fill, cards[1].fill, cards[2].fill)
        let sameColor = compareThreeElements(cards[0].color, cards[1].color, cards[2].color)
        
        return sameShapes && sameNum && sameFill && sameColor
    }
    
    private func compareThreeElements<T: Equatable>(_ elementOne: T, _ elementTwo: T, _ elementThree: T) -> Bool {
        let allSame = (elementOne == elementTwo) && (elementTwo == elementThree)
        let allDiff = (elementOne != elementTwo) && (elementTwo != elementThree) && (elementOne != elementThree)
        return allSame || allDiff
    }
    
    struct Card: Identifiable, Equatable {
        let number: Int
        let shape: Shape
        let fill: Fill
        let color: String
        var matched: Bool = false
        var isChosen: Bool = false
        let id: String
        
        enum Shape: CaseIterable, Equatable { case Diamond, Squiggle, Oval }
        
        enum Fill: CaseIterable, Equatable { case Solid, Striped, Open }
    }
}
