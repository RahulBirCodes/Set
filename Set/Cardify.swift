//
//  Cardify.swift
//  Set
//

//  Created by Rahul Bir on 6/27/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    let rect = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
    
    func body(content: Content) -> some View {
        ZStack {
            rect.fill().foregroundColor(.white)
            rect.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            content
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify() -> some View {
        self.modifier(Cardify())
    }
}
