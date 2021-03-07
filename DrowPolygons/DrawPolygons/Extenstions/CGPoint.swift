//
//  CGPoint.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 05/03/21.
//

import UIKit

extension CGPoint {
    private func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    func distanceBetween(point: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: self, to: point))
    }
}

extension CGPoint {
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
    
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        var result: CGPoint = .zero
        result.x = lhs.x - rhs.x
        result.y = lhs.y - rhs.y
        return result
    }
}
