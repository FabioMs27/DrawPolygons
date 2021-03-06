//
//  CanDraw.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import GameplayKit

class CanDraw: PolygonState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is StartPoint.Type
    }
}
