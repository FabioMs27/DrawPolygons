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
        if let _ = previousState?.isMember(of: CanDraw.self) {
            scene.addNewPolygon()
        }
        currentPolygon?.points.append(scene.currentPoint)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is StartPoint.Type ||
            stateClass is DrawLine.Type ||
            stateClass is CancelDraw.Type
    }
}
