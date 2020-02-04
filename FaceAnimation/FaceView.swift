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
    
    enum Eye {
        case left
        case right
    }
    
    
    private func pathForeye(_ eye: Eye) -> UIBezierPath {
        func centerEye (_ eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratio.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
         }
        
        let eyeRadius = skullRadius /  Ratio.skullRadiusToEyeRadius
        let eyeCenter = centerEye(eye)
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        path.lineWidth = 2.0
        
        return path
    }
    
    private struct Ratio {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusMothOffset: CGFloat = 3
        static let skullRadiusMouthWidth: CGFloat = 1
        static let skullRadisMouthHeight : CGFloat = 3
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathSkull().stroke()
        pathForeye(.left).stroke()
        pathForeye(.right).stroke()
    } 
}
