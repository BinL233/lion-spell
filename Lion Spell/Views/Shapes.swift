//
//  Shapes.swift
//  Lion Spell
//
//  Created by Kaile Ying on 9/11/23.
//

import SwiftUI

struct Shapes : Shape {
    var side: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let shapeAngle = 2 * CGFloat.pi / CGFloat(side-1)

        for i in 0..<(side-1) {
            let angle = CGFloat(i) * shapeAngle - CGFloat.pi / 2
            let pos = CGPoint(x: center.x + rect.width / 2 * cos(angle), y: center.y + rect.width / 2 * sin(angle))

            if i == 0 {
                path.move(to: pos)
            } else {
                path.addLine(to: pos)
            }
        }
        path.closeSubpath()
        
        return path
    }
}
