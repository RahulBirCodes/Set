//
//  SetGameView.swift
//  Set
//
//  Created by Rahul Bir on 5/26/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGameViewModel
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack {
            Group {
                if let match = setGame.match {
                    if match {
                        Color.mint
                    } else {
                        Color.pink
                    }
                } else {
                    Color.clear
                }
            }
            .ignoresSafeArea()
            .transition(.asymmetric(insertion: .scale, removal: .identity))
            
            VStack {
                AspectVGrid(items: setGame.cardsCurrentlyInGame, aspectRatio: 2/3) { card in
                    CardView(card: card, isDealt: true).aspectRatio(2/3, contentMode: .fit)
                        .padding(5)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .id(card.id)
                        .onTapGesture {
                            withAnimation {
                                setGame.choose(card)
                            }
                        }
                }
                Spacer()
                HStack {
                    undealtCards
                    Spacer()
                    matchedCards
                }
                .padding(5)
            }
        }
    }
    
    private func zIndex(of card: SetGame.Card) -> Double {
        -Double(setGame.undealtCards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var undealtCards: some View {
        ZStack {
            ForEach(setGame.undealtCards) { card in
                CardView(card: card, isDealt: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .onTapGesture {
            withAnimation {
                setGame.dealCards()
            }
        }
    }
    
    var matchedCards: some View {
        ZStack {
            ForEach(setGame.matchedCards) { card in
                CardView(card: card, isDealt: true)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameViewModel())
            .previewDevice("iPhone 13 Pro")
    }
}
