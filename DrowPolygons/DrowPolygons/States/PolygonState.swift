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
    
    init(scene: Drawable) {
        self.scene = scene
        super.init()
    }
}
