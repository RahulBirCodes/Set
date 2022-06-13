//
//  SetGameView.swift
//  Set
//
//  Created by Rahul Bir on 5/26/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGameViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                AspectVGrid(items: setGame.cardsCurrentlyInGame, aspectRatio: 2/3) { card in
                    CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                        .padding(5)
                        .onTapGesture {
                            setGame.choose(card)
                        }
                }
                
                //            HStack {
                //                newGameButton
                //                Spacer()
                //                deal3CardsButton
                //            }
                //            .padding(.horizontal)
                //            .font(.largeTitle)
            }
            undealtCards
        }
    }
    
//    var newGameButton: some View {
//        Button {
//            setGame.newGame()
//        } label: {
//            Text("New Game")
//        }
//    }
    
    var undealtCards: some View {
        ZStack {
            ForEach(setGame.undealtCards) { card in
                CardView(card: card)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .onTapGesture {
            setGame.dealCards()
        }
    }
    
//    var deal3CardsButton: some View {
//        Button {
//            setGame.deal3Cards()
//        } label: {
//            HStack(spacing: 0) {
//                Image(systemName: "plus")
//                Text("3")
//            }
//        }
//        .disabled(setGame.disableButton())
//    }
    
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
