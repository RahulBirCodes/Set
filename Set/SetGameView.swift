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
        VStack {
            AspectVGrid(items: setGame.cards, aspectRatio: 2/3) { card in
                CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                    .padding(5)
                    .onTapGesture {
                        if !(card.matched != nil && card.matched! == true) {
                            setGame.choose(card)
                        }
                    }
            }
//            Spacer()
            HStack {
                newGameButton
                Spacer()
                deal3CardsButton
            }
            .padding(10)
            .font(.largeTitle)
        }
    }
    var newGameButton: some View {
        Button {
            setGame.newGame()
        } label: {
            Text("New Game")
        }
    }
    var deal3CardsButton: some View {
        Button {
            setGame.deal3Cards()
        } label: {
            HStack(spacing: 0) {
                Image(systemName: "plus")
                Text("3")
            }
        }

    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameViewModel())
            .previewDevice("iPhone 13 Pro")
    }
}
