//
//  Validation.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import GameplayKit

class DrawValidation: PolygonState {
    override func didEnter(from previousState: GKState?) {
        guard let polygon = currentPolygon else {
            fatalError("Polygon wasn't added as supossed!")
        }
        if polygon.shlouldClose() {
            stateMachine?.enter(CanDraw.self)
            return
        } else if !polygon.isValid {
            polygon.points.removeLast()
        }
        currentPolygon?.redraw()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is StartPoint.Type ||
            stateClass is CanDraw.Type ||
            stateClass is CancelDraw.Type
    }
}
