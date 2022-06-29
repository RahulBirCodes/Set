//
//  Cardify.swift
//  Set
//

//  Created by Rahul Bir on 6/27/22.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    var animatableData: CGFloat {
        get { scale }
        set { scale = newValue }
    }
    
    init(isChosen: Bool) {
        scale = isChosen ? 1.1 : 1
        shadowRadius = isChosen ? 5 : 0
    }
    
    var scale: CGFloat
    var shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            let rect = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            rect.fill().foregroundColor(.white)
            rect.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            content
        }
        .shadow(radius: shadowRadius)
        .scaleEffect(x: scale, y: scale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isChosen: Bool) -> some View {
        self.modifier(Cardify(isChosen: isChosen))
    }
}
