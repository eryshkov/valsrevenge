//
//  SKScene+ViewProperties.swift
//  valsrevenge
//
//  Created by Evgenii Ryshkov on 15.01.2022.
//

import SpriteKit

extension SKScene {
    var viewTop: CGFloat {
        return convertPoint(fromView: CGPoint.zero).y
    }
    
    var viewBottom: CGFloat {
        guard let view = view else { return 0.0 }
        return convertPoint(fromView: CGPoint(x: 0, y: view.bounds.size.height)).y
    }
    
    var viewLeft: CGFloat {
        return convertPoint(fromView: CGPoint.zero).x
    }
    
    var viewRight: CGFloat {
        guard let view = view else { return 0.0 }
        return convertPoint(fromView: CGPoint(x: view.bounds.size.width, y: 0)).x
    }
}
