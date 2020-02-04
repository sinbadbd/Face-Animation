//
//  FaceView.swift
//  FaceAnimation
//
//  Created by Sinbad on 4/2/20.
//  Copyright © 2020 Sinbad. All rights reserved.
//

import UIKit

class FaceView: UIView {
 
    var scale: CGFloat = 0.9 // Padding all side
    
    
    private var skullRadius : CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private func pathSkull() -> UIBezierPath {
    
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5
        return path
    
    }
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathSkull().stroke() 
    } 
}
