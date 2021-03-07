//
//  CanMove.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 07/03/21.
//

import GameplayKit

class CanMove: PolygonState {
    override func didEnter(from previousState: GKState?) {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is CanDraw.Type ||
            stateClass is SelectPolygon.Type
    }
}
