//
//  SetGame.swift
//  Set
//
//  Created by Rahul Bir on 5/26/22.
//

import Foundation

struct SetGame {
    
    private var cards: [Card]
    var cardsInGame: [Card]
    
    private(set) var colors: [String]
    
    private var selectedCardsIndices: [Int] {
        get { cardsInGame.indices.filter({ cardsInGame[$0].isChosen })}
        set { cardsInGame.indices.forEach({ cardsInGame[$0].isChosen = newValue.contains($0)})}
    }
    
    mutating func choose(_ card: Card) {
        if selectedCardsIndices.count == 3 { resetCardsAfterMatchCheck() }
        if let chosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
            // Deselect card
            if cardsInGame[chosenIndex].isChosen {
                cardsInGame[chosenIndex].isChosen = false
                selectedCardsIndices.removeAll(where: { $0 == chosenIndex })
                print("huhhhhhh")
            } else {
                selectedCardsIndices.append(chosenIndex)
                print(selectedCardsIndices)
                if selectedCardsIndices.count == 3 {
                    if checkMatch(for: selectedCardsIndices.map({ cardsInGame[$0] })) {
                        selectedCardsIndices.forEach({ cardsInGame[$0].matched = true })
                    } else {
                        selectedCardsIndices.forEach({ cardsInGame[$0].matched = false })
                    }
                }
            }
        }
    }
    
    private mutating func resetCardsAfterMatchCheck() {
        // change code so that matching cards get replaced with new cards 
        cardsInGame.removeAll { $0.matched != nil && $0.matched! == true }
        cardsInGame.indices.forEach {
            if let matched = cardsInGame[$0].matched {
                if !matched {
                    cardsInGame[$0].matched = nil
                }
            }
        }
        selectedCardsIndices.removeAll()
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

    init(colors: [String], maxNumberOfShapes: Int) {
        cards = []
        self.colors = colors
        
        var id = 0
        for num in 1...maxNumberOfShapes {
            for shape in Card.Shape.allCases {
                for fill in Card.Fill.allCases {
                    for color in colors {
                        cards.append(Card(number: num, shape: shape, fill: fill, color: color, id: id))
                        id += 1
                    }
                }
            }
        }
        cards.shuffle()
        cardsInGame = Array(cards[0...11])
    }
    
    struct Card: Identifiable {
        let number: Int
        let shape: Shape
        let fill: Fill
        let color: String
        var matched: Bool?
        var isChosen: Bool = false
        let id: Int
        
        enum Shape: CaseIterable, Equatable { case Diamond, Squiggle, Oval }
        
        enum Fill: CaseIterable, Equatable { case Solid, Striped, Open }
    }
}
