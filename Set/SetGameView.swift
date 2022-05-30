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
        AspectVGrid(items: setGame.cards, aspectRatio: 2/3) { card in
            CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                .padding(5)
                .onTapGesture {
                    setGame.choose(card)
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
