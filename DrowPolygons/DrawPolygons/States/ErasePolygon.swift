//
//  ErasePolygon.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 07/03/21.
//

import GameplayKit

class ErasePolygon: PolygonState {
    override func didEnter(from previousState: GKState?) {
        selectedPolygon?.removeFromSuperlayer()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is CanErase.Type
    }
}
