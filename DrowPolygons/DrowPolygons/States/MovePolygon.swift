//
//  MovePolygon.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 07/03/21.
//

import GameplayKit

class MovePolygon: PolygonState {
    override func didEnter(from previousState: GKState?) {
        scene.movePolygon()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is CanMove.Type ||
            stateClass is MovePolygon.Type
    }
}
