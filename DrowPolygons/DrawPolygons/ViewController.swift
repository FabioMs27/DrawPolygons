//
//  ViewController.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 05/03/21.
//

import UIKit
import GameplayKit

protocol Drawable: UIViewController {
    var initialTouch: CGPoint { get }
    var currentTouch: CGPoint { get }
    var currentPolygon: Polygon? { get set }
    var selectedPolygon: Polygon? { get set }
}

class ViewController: UIViewController, Drawable {
    var selectedPolygon: Polygon?
    var initialTouch: CGPoint  = .zero
    var currentTouch: CGPoint = .zero
    var currentPolygon: Polygon?
    
    private lazy var stateMachine: GKStateMachine = { [weak self] in
        guard let self = self else {
            fatalError("View not captured!")
        }
        let stateMachine = GKStateMachine(states: [
            CanDraw(scene: self), ErasePolygon(scene: self),
            DrawLine(scene: self), DrawValidation(scene: self),
            CancelDraw(scene: self), CanMove(scene: self),
            SelectPolygon(scene: self), MovePolygon(scene: self),
            CanErase(scene: self), StartPoint(scene: self)
        ])
        stateMachine.enter(CanDraw.self)
        return stateMachine
    }()
    
    @IBAction func draw(_ sender: UIButton) {
        enter(state: .canDraw)
    }
    @IBAction func erase(_ sender: UIButton) {
        enter(state: .cancelDraw)
        enter(state: .canErase)
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

//MARK: - Touch handling
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: view) else { return }
        initialTouch = touchLocation
        currentTouch = touchLocation
        enter(state: .startPoint)
        enter(state: .selectPolygon)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: view) else { return }
        currentTouch = touchLocation
        enter(state: .drawLine)
        enter(state: .movePolygon)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let state = stateMachine.currentState else { return }
        if state.isMember(of: MovePolygon.self) {
            enter(state: .canMove)
        } else {
            enter(state: .canErase)
        }
        enter(state: .validateDraw)
    }
}
