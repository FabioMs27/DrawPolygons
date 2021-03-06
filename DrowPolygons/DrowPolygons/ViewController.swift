//
//  ViewController.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 05/03/21.
//

import UIKit

protocol Drawable: class {
    var currentPoint: CGPoint { get }
    var currentPolygon: Polygon? { get }
    func addNewPolygon()
    func showAlert(title: String, message: String)
}

class ViewController: UIViewController {
    var polygons = [Polygon]()
    private var currentTouches = Set<UITouch>()
    var currentPolygon: Polygon? {
        polygons.last
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewPolygon()
    }
    
    @IBAction func draw(_ sender: UIButton) { }
    @IBAction func erase(_ sender: UIButton) { }
    @IBAction func movePolygon(_ sender: UIButton) { }
    @IBAction func moveDot(_ sender: UIButton) { }
}

//MARK: - Drawable
extension ViewController: Drawable {
    var currentPoint: CGPoint {
        get { getPoint(from: currentTouches) }
    }
    
    func addNewPolygon() {
        let polygon = Polygon()
        self.view.layer.addSublayer(polygon.shapeLayer)
        polygons.append(polygon)
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
    
    private func getPoint(from touches: Set<UITouch>) -> CGPoint {
        guard let touch = touches.first else {
            fatalError("No touches found!")
        }
        return touch.location(in: self.view)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
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
