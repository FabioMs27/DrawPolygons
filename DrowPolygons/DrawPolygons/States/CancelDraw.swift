//
//  Cancel.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import GameplayKit
import SpriteKit

class CancelDraw: PolygonState {
    override func didEnter(from previousState: GKState?) {
        guard let state = previousState else { return }
        if state.isMember(of: DrawLine.self) {
            currentPolygon?.points.removeLast()
        }
        showAlert(title: "Your polygon will be deleted!", message: "Are you sure you want to proceed?")
    }
    
    override func willExit(to nextState: GKState) {
        if nextState.isMember(of: CanDraw.self) {
            currentPolygon?.removeFromSuperlayer()
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is StartPoint.Type ||
            stateClass is CanDraw.Type
    }
}
