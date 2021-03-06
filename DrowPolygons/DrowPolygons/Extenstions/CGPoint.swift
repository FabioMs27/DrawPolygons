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
