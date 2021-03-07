//
//  ViewController.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 05/03/21.
//

import UIKit
import GameplayKit

protocol Drawable: class {
    var currentPoint: CGPoint { get }
    var currentPolygon: Polygon? { get }
    func addNewPolygon()
    func removePolygon()
    func movePolygon()
    func selectPolygon()
    func showAlert(title: String, message: String)
}

class ViewController: UIViewController {
    var polygons = [Polygon]()
    var selectedPolygon: Polygon?
    private var currentTouches = Set<UITouch>()
    private lazy var stateMachine: GKStateMachine = { [weak self] in
        guard let self = self else {
            fatalError("View not captured!")
        }
        let stateMachine = GKStateMachine(states: [
            CanDraw(scene: self), StartPoint(scene: self),
            DrawLine(scene: self), DrawValidation(scene: self),
            CancelDraw(scene: self), CanMove(scene: self),
            SelectPolygon(scene: self), MovePolygon(scene: self)
        ])
        stateMachine.enter(CanDraw.self)
        return stateMachine
    }()
    var currentPolygon: Polygon? {
        polygons.last
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewPolygon()
    }
    
    @IBAction func draw(_ sender: UIButton) {
        enter(state: .canDraw)
    }
    @IBAction func erase(_ sender: UIButton) {
        enter(state: .cancelDraw)
    }
    @IBAction func movePolygon(_ sender: UIButton) {
        enter(state: .cancelDraw)
        enter(state: .canMove)
    }
    @IBAction func moveDot(_ sender: UIButton) {
        enter(state: .cancelDraw)
    }
    
    func enter(state: AvailableStates) {
        stateMachine.enter(state.type)
    }
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
    
    func removePolygon() {
        let lastPolygon = polygons.removeLast()
        lastPolygon.shapeLayer.removeFromSuperlayer()
    }
    
    func movePolygon() {
        selectedPolygon?.move(to: currentPoint)
    }
    
    func selectPolygon() {
        selectedPolygon = polygons.filter { $0.shapeLayer.path?.contains(currentPoint) ?? false }.first
        selectedPolygon?.initialPos = currentPoint
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            self?.enter(state: .canDraw)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.enter(state: .validateDraw)
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func getPoint(from touches: Set<UITouch>) -> CGPoint {
        guard let touch = touches.first else {
            fatalError("No touches found!")
        }
        return touch.location(in: self.view)
    }
}

//MARK: - Touch handling
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentTouches = touches
        enter(state: .startPoint)
        enter(state: .selectPolygon)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentTouches = touches
        enter(state: .drawLine)
        enter(state: .movePolygon)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        enter(state: .canMove)
        enter(state: .validateDraw)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
