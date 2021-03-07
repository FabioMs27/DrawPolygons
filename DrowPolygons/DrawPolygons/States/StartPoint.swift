//
//  StartPoint.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 07/03/21.
//

import Foundation
import GameplayKit

class StartPoint: PolygonState {
    override func didEnter(from previousState: GKState?) {
        if currentPolygon == nil {
            scene.currentPolygon = Polygon()
            scene.view.layer.addSublayer(currentPolygon!)
        }
        currentPolygon?.add(point: scene.currentTouch)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is CancelDraw.Type ||
            stateClass is DrawLine.Type ||
            stateClass is DrawValidation.Type ||
            stateClass is StartPoint.Type
    }
}
