//
//  AvailableStates.swift
//  DrowPolygons
//
//  Created by Fábio Maciel de Sousa on 06/03/21.
//

import Foundation
import GameplayKit

enum AvailableStates {
    case canDraw
    case startPoint
    case drawLine
    case validateDraw
    case cancelDraw
    case canMove
    case movePolygon
    case selectPolygon
    case canErase
    case erasePolygon
    
    var type: GKState.Type {
        switch self {
        case .canDraw:    return CanDraw.self
        case .cancelDraw: return CancelDraw.self
        case .drawLine:   return DrawLine.self
        case .startPoint: return StartPoint.self
        case .validateDraw: return DrawValidation.self
        case .canMove: return CanMove.self
        case .movePolygon: return MovePolygon.self
        case .selectPolygon: return SelectPolygon.self
        case .canErase: return CanErase.self
        case .erasePolygon: return ErasePolygon.self
        }
    }
}
