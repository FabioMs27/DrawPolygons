//
//  DrawLine.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import Foundation
import GameplayKit

class DrawLine: PolygonState {
    override func didEnter(from previousState: GKState?) {
        if let _ = previousState?.isMember(of: StartPoint.self) {
            currentPolygon?.points.append(scene.currentPoint)
        }
        currentPolygon?.points.removeLast()
        currentPolygon?.points.append(scene.currentPoint)
        currentPolygon?.redraw()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is CancelDraw.Type ||
            stateClass is DrawLine.Type ||
            stateClass is Validation.Type
    }
}
