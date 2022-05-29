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
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(setGame.cards) { card in
                    CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                        .padding(5)
                }
            }
        }
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: SetGameViewModel())
    }
}
