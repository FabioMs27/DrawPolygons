//
//  PolygonState.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import GameplayKit

class PolygonState: GKState {
    unowned let scene: Drawable
    var currentPolygon: Polygon? {
        scene.currentPolygon
    }
    var selectedPolygon: Polygon? {
        scene.selectedPolygon
    }
    var touchDistance: CGPoint {
        scene.currentTouch - scene.initialTouch
    }
    
    init(scene: Drawable) {
        self.scene = scene
        super.init()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            self?.stateMachine?.enter(CanDraw.self)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { [weak self] _ in
            self?.stateMachine?.enter(DrawValidation.self)
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        scene.present(alert, animated: true)
    }
}
