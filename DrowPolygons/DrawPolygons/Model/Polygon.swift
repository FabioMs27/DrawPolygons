//
//  Polygon.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 05/03/21.
//

import UIKit

enum PolygonMetrics {
    static var lineWidth: CGFloat = 2.0
    static var strokeColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1).cgColor
    static var fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
    static var distanceToClose: CGFloat = 25.0
}

class Polygon: CAShapeLayer {
    private let bezierPath = UIBezierPath()
    private let validator: LineValidating
    var points = [CGPoint]()
    var isValid: Bool {
        validator.validate(points: points)
    }
    var shouldClose: Bool {
        if let startPoint = points.first,
           let endPoint = points.last,
           points.count > 2 {
            let distance = startPoint.distanceBetween(point: endPoint)
            if distance <= PolygonMetrics.distanceToClose {
                return true
            }
        }
        return false
    }
    
    init(validator: LineValidating = IntersectionValidator()) {
        self.validator = validator
        super.init()
        strokeColor = PolygonMetrics.strokeColor
        fillColor = UIColor.clear.cgColor
        lineWidth = PolygonMetrics.lineWidth
        position = .zero
    }
    
    override init(layer: Any) {
        self.validator = IntersectionValidator()
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(point: CGPoint) {
        if points.isEmpty {
            points.append(contentsOf: [point, point])
        } else {
            points.append(point)
        }
        redraw()
    }
    
    func close() {
        points.removeLast()
        redraw()
        bezierPath.close()
        fillColor = PolygonMetrics.fillColor
        path = bezierPath.cgPath
    }
    
    func redraw() {
        guard let startPoint = points.first else { return }
        bezierPath.removeAllPoints()
        bezierPath.move(to: startPoint)
        for i in 1..<points.count {
            bezierPath.addLine(to: points[i])
        }
        path = bezierPath.cgPath
    }
}
