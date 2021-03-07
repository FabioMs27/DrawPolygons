//
//  SelectPolygon.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 07/03/21.
//

import GameplayKit

class SelectPolygon: PolygonState {
    override func didEnter(from previousState: GKState?) {
        scene.selectPolygon()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is MovePolygon.Type ||
            stateClass is CanMove.Type
    }
}
