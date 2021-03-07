//
//  Validation.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import GameplayKit

class DrawValidation: PolygonState {
    override func didEnter(from previousState: GKState?) {
        guard let polygon = currentPolygon else { return }
        if polygon.shouldClose {
            polygon.close()
            scene.currentPolygon = nil
            stateMachine?.enter(CanDraw.self)
        } else if !polygon.isValid {
            polygon.points.removeLast()
            polygon.redraw()
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is StartPoint.Type ||
            stateClass is CanDraw.Type ||
            stateClass is CancelDraw.Type
    }
}
