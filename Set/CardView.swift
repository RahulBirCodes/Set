//
//  CardView.swift
//  Set
//
//  Created by Rahul Bir on 5/29/22.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
//    let rect = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
    
    var body: some View {
        GeometryReader { geometry in
//            ZStack {
//                rect.fill().foregroundColor(.white)
//                rect.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    
                VStack {
                    ForEach((1...card.number), id: \.self) { num in
                        let scaleRatio: CGFloat = CGFloat(Double(card.number)/3)
                        findShapeAndFill(scale: scaleRatio)
                            .foregroundColor(SetGameViewModel.findColorValue(card.color))
                    }
                }
                .padding(DrawingConstants.padding)
                .modifier(Cardify())
//            }
        }
    }
    
    @ViewBuilder
    func findShapeAndFill(scale: CGFloat) -> some View {
        switch card.fill {
        case .Solid:
            filledShape(scale: scale)
        case .Open:
            strokedShape(scale: scale)
        case .Striped:
            shadedSymbol(scale: scale)
        }
    }
    
    @ViewBuilder
    private func filledShape(scale: CGFloat) -> some View {
        switch card.shape {
        case .Diamond:
            Diamond().scale(x: 1, y: scale)
        case .Squiggle:
            Rectangle().scale(x: 1, y: scale)
        case .Oval:
            Ellipse().scale(x: 1, y: scale)
        }
    }
    
    @ViewBuilder
    private func strokedShape(scale: CGFloat) -> some View {
        switch card.shape {
        case .Diamond:
            Diamond().scale(x: 1, y: scale).stroke(lineWidth: DrawingConstants.shapeLineWidth)
        case .Squiggle:
            Rectangle().scale(x: 1, y: scale).stroke(lineWidth: DrawingConstants.shapeLineWidth)
        case .Oval:
            Ellipse().scale(x: 1, y: scale).stroke(lineWidth: DrawingConstants.shapeLineWidth)
        }
    }
    
    @ViewBuilder
    private func shadedSymbol(scale: CGFloat) -> some View {
        ZStack {
            filledShape(scale: scale)
                .opacity(DrawingConstants.shadedSymbolOpacity)
            strokedShape(scale: scale)
        }
    }
    
    private struct DrawingConstants {
        static let shapeLineWidth: CGFloat = 2
        static let padding: CGFloat = 8
        static let shadedSymbolOpacity: CGFloat = 0.5
    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
