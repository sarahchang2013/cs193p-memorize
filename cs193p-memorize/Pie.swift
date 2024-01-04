//
//  Pie.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2024/1/4.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    let startAngle: Angle = .zero
    var endAngel: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.height, rect.width) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngel,
            clockwise: false
        )
        p.addLine(to: center)
        return p
    }
    
    
}
