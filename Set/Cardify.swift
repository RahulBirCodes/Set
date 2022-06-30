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
    
    init(isChosen: Bool, isDealt: Bool) {
        dealt = isDealt
        scale = isChosen ? 1.1 : 1
        shadowRadius = isChosen ? 5 : 0
    }
    
    var scale: CGFloat
    var shadowRadius: CGFloat
    var dealt: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let rect = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if dealt {
                rect.fill().foregroundColor(.white)
                rect.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                content
            } else {
                rect.fill().foregroundColor(DrawingConstants.themeColor)
            }
        }
        .shadow(radius: shadowRadius)
        .scaleEffect(x: scale, y: scale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 3
        static let themeColor: Color = .indigo
    }
}

extension View {
    func cardify(isChosen: Bool, isDealt: Bool) -> some View {
        self.modifier(Cardify(isChosen: isChosen, isDealt: isDealt))
    }
}
