//
//  Polygon.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 05/03/21.
//

import UIKit

class Polygon {
    private var path = UIBezierPath()
    private var validator = LineValidator()
    var points = [CGPoint]()
    
    private(set) lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.position = .zero
        return shapeLayer
    }()
    
    private func closePolygon() {
        points.removeLast()
        redraw()
        path.close()
        shapeLayer.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        shapeLayer.path = path.cgPath
    }
    
    func redraw() {
        guard let startPoint = points.first else { return }
        path.removeAllPoints()
        path.move(to: startPoint)
        for i in 1..<points.count {
            path.addLine(to: points[i])
        }
        shapeLayer.path = path.cgPath
    }
    
    func shlouldClose() -> Bool {
        if let startPoint = points.first,
           let endPoint = points.last,
           points.count > 2 {
            let distance = startPoint.distanceBetween(point: endPoint)
            if distance <= 25.0 {
                closePolygon()
                return true
            }
        }
        return false
    }
    
    func cancelLine() {
        points.removeLast()
        redraw()
    }
    
    func checkIntersections() {
        validator.makeLines(from: points)
        if validator.shouldCancel() {
            cancelLine()
        }
    }
}
