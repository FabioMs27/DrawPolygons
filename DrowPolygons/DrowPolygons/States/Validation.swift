//
//  Validation.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import GameplayKit

class Validation: PolygonState {
    override func didEnter(from previousState: GKState?) {
        guard let polygon = currentPolygon else {
            fatalError("Polygon wasn't added as supossed!")
        }
        if !polygon.isValid {
            if polygon.points.count <= 2 {
                polygon.points.removeAll()
            } else {
                polygon.points.removeLast()
            }
        } else if polygon.shlouldClose() {
            stateMachine?.enter(CanDraw.self)
            return
        }
        stateMachine?.enter(StartPoint.self)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is StartPoint.Type
    }
}
