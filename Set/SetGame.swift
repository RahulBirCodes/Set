//
//  SetGame.swift
//  Set
//
//  Created by Rahul Bir on 5/26/22.
//

import Foundation

struct SetGame {
    
    private(set) var cards: [Card]
    private(set) var colors: [String]
    
    private var selectedCardsIndices: [Int] {
        get { cards.indices.filter({ cards[$0].isChosen })}
        set { cards.indices.forEach({ cards[$0].isChosen = newValue.contains($0)})}
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            // Deselect card
            if card.isChosen {
                cards[chosenIndex].isChosen = false
                selectedCardsIndices.removeAll(where: { $0 == chosenIndex })
            } else {
                if selectedCardsIndices.count < 3 {
                    selectedCardsIndices.append(chosenIndex)
                } else {
                    selectedCardsIndices = [chosenIndex]
                }
            }
        }
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
        print(cards.count)
    }
    
    struct Card: Identifiable {
        let number: Int
        let shape: Shape
        let fill: Fill
        let color: String
        var isPartOfSet: Bool = false
        var isChosen: Bool = false
        let id: Int
        
        enum Shape: CaseIterable { case Diamond, Squiggle, Oval }
        
        enum Fill: CaseIterable { case Solid, Striped, Open }
    }
}
