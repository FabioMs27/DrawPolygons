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
    
    var type: GKState.Type {
        switch self {
        case .canDraw:    return CanDraw.self
        case .cancelDraw: return CancelDraw.self
        case .drawLine:   return DrawLine.self
        case .startPoint: return StartPoint.self
        case .validateDraw: return DrawValidation.self
        }
    }
}
