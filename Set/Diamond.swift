//
//  Diamond.swift
//  Set
//
//  Created by Rahul Bir on 5/27/22.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var p = Path()
        p.move(to: CGPoint(x: CGFloat.zero, y: center.y))
        p.addLine(to: CGPoint(x: rect.width/2, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: center.y))
        p.addLine(to: CGPoint(x: rect.width/2, y: rect.height))
        p.addLine(to: CGPoint(x: CGFloat.zero, y: center.y))
        
        return p
    }
}
