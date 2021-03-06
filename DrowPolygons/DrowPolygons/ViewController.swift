//
//  ViewController.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 05/03/21.
//

import UIKit

class ViewController: UIViewController {
    var polygons = [Polygon]()
    var currentPolygon: Polygon? {
        polygons.last
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewPolygon()
    }
    
    func addNewPolygon() {
        let polygon = Polygon()
        self.view.layer.addSublayer(polygon.shapeLayer)
        polygons.append(polygon)
    }
    
    func getPoint(from touches: Set<UITouch>) -> CGPoint {
        guard let touch = touches.first else {
            fatalError("No touches found!")
        }
        return touch.location(in: self.view)
    }
    
    func updatePath(from touche: CGPoint) {
        guard let polygon = currentPolygon else { return }
        if polygon.points.count == 1 {
            polygon.points.append(touche)
        }
        polygon.points.removeLast()
        polygon.points.append(touche)
        polygon.redraw()
    }
    
    @IBAction func draw(_ sender: UIButton) { }
    @IBAction func erase(_ sender: UIButton) { }
    @IBAction func movePolygon(_ sender: UIButton) { }
    @IBAction func moveDot(_ sender: UIButton) { }
}

//MARK: - Touch handling
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchePoint = getPoint(from: touches)
        currentPolygon?.points.append(touchePoint)
        updatePath(from: touchePoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchePoint = getPoint(from: touches)
        updatePath(from: touchePoint)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let polygon = currentPolygon else { return }
        polygon.checkIntersections()
        if polygon.shlouldClose() { addNewPolygon() }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentPolygon?.cancelLine()
    }
}
