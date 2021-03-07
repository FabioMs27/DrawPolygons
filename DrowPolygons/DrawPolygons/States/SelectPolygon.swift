//
//  SelectPolygon.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 07/03/21.
//

import GameplayKit

class SelectPolygon: PolygonState {
    override func didEnter(from previousState: GKState?) {
        guard let state = previousState else { return }
        if state.isMember(of: CanMove.self) {
            stateMachine?.enter(MovePolygon.self)
        } else {
            stateMachine?.enter(ErasePolygon.self)
        }
        if let polygon = scene.view.layer.sublayers?.first(where: { ($0 as? CAShapeLayer)?.path?.contains(scene.currentTouch) ?? false }) as? Polygon {
            scene.selectedPolygon = polygon
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is MovePolygon.Type ||
            stateClass is ErasePolygon.Type
    }
}
