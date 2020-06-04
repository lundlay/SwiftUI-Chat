//
//  BuubleShape.swift
//  Victoria-Chat
//
//  Created by Oleg Lavronov on 6/4/20.
//  Copyright © 2020 Lundlay. All rights reserved.
//

import SwiftUI

struct BuubleShape: Shape {
    let radius: CGFloat
    let arrowSize: CGSize
    let left: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        if left {
            path.move(to: CGPoint(x: rect.minX + arrowSize.width, y: rect.minY + radius))
            path.addRelativeArc(center: CGPoint(x: rect.minX + arrowSize.width + radius, y: rect.minY + radius),
                                radius: radius,
                                startAngle: Angle.degrees(180),
                                delta: Angle.degrees(90))
            
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addRelativeArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                                radius: radius,
                                startAngle: Angle.degrees(270),
                                delta: Angle.degrees(90))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
            path.addRelativeArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                                radius: radius,
                                startAngle: Angle.degrees(0),
                                delta: Angle.degrees(90))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + arrowSize.width, y: rect.maxY - arrowSize.height))
        } else {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            path.addRelativeArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                                radius: radius,
                                startAngle: Angle.degrees(180),
                                delta: Angle.degrees(90))

            path.addLine(to: CGPoint(x: rect.maxX - arrowSize.width - radius, y: rect.minY))
            path.addRelativeArc(center: CGPoint(x: rect.maxX - arrowSize.width - radius, y: rect.minY + radius),
                                radius: radius,
                                startAngle: Angle.degrees(270),
                                delta: Angle.degrees(90))
            path.addLine(to: CGPoint(x: rect.maxX - arrowSize.width, y: rect.maxY - arrowSize.height))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
            path.addRelativeArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius),
                                radius: radius,
                                startAngle: Angle.degrees(90),
                                delta: Angle.degrees(90))
        }

        return path
    }
}

