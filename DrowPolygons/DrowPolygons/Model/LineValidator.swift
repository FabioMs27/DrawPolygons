//
//  LineValidator.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 05/03/21.
//

import UIKit
import Foundation

typealias Line = (startPoint: CGPoint, endPoint: CGPoint)

protocol LineValidatable: class {
    var lines: [Line] { get set }
    func validate(points: [CGPoint]) -> Bool
}

class LineValidator: LineValidatable {
    internal var lines = [Line]()
    
    func validate(points: [CGPoint]) -> Bool {
        if points.count < 2 { return true }
        lines.removeAll()
        var pointsCopy = points
        pointsCopy.removeFirst()
        while !pointsCopy.isEmpty {
            let firstPoint = pointsCopy.removeFirst()
            if let secondPoint = pointsCopy.first {
                let line = (startPoint: firstPoint, endPoint: secondPoint)
                lines.append(line)
            }
        }
        return !shouldCancel
    }
}

//MARK: - Validation algorithm
private extension LineValidator {
    var shouldCancel: Bool {
        guard let lastLine = lines.popLast() else { return false }
        return lines
            .map { compareIntersections(line: lastLine, with: $0) }
            .reduce(false, { $0 || $1 }) || compareDistance(fromPointsIn: lastLine)
    }
    
    func compareDistance(fromPointsIn line: Line) -> Bool {
        line.startPoint.distanceBetween(point: line.endPoint) < 12.0
    }
    
    func compareIntersections(line: Line, with secondLine: Line) -> Bool {
        let delta1x = line.endPoint.x - line.startPoint.x
        let delta1y = line.endPoint.y - line.startPoint.y
        let delta2x = secondLine.endPoint.x - secondLine.startPoint.x
        let delta2y = secondLine.endPoint.y - secondLine.startPoint.y
        let determinant = delta1x * delta2y - delta2x * delta1y
        if abs(determinant) < 0.0001 {
            return false
        }
        let ab = ((line.startPoint.y - secondLine.startPoint.y) * delta2x - (line.startPoint.x - secondLine.startPoint.x) * delta2y) / determinant
        if ab > 0 && ab < 1 {
            let cd = ((line.startPoint.y - secondLine.startPoint.y) * delta1x - (line.startPoint.x - secondLine.startPoint.x) * delta1y) / determinant
            if cd > 0 && cd < 1 {
                return true
            }
        }
        return false
    }
}
