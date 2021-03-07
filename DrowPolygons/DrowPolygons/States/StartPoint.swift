//
//  StartingPoint.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import Foundation
import GameplayKit

class StartPoint: PolygonState {
    override func didEnter(from previousState: GKState?) {
        guard let state = previousState else { return }
        if state.isMember(of: CanDraw.self) {
            scene.addNewPolygon()
            currentPolygon?.points.append(scene.currentPoint)
        }
        currentPolygon?.points.append(scene.currentPoint)
        currentPolygon?.redraw()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is DrawLine.Type ||
            stateClass is DrawValidation.Type
    }
}
