//
//  FaceView.swift
//  FaceAnimation
//
//  Created by Sinbad on 4/2/20.
//  Copyright © 2020 Sinbad. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var scale: CGFloat = 0.9 // Padding all side
    
    @IBInspectable
    var eyeClose: Bool = true
    
    @IBInspectable
    var mouthCurvature: Double = 0.5
    
    @IBInspectable
    var color: UIColor = UIColor.blue
    
    @IBInspectable
    var lineWith : CGFloat = 0.5
    
    private var skullRadius : CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private func pathSkull() -> UIBezierPath {
        
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = lineWith
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
        
        let path : UIBezierPath
        if eyeClose {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
            print(eyeClose)
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            print(eyeClose)
        }
        path.lineWidth = lineWith
        return path
    }
    
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratio.skullRadiusMouthWidth
        let mouthHeight = skullRadius / Ratio.skullRadisMouthHeight
        let mouthOffset = skullRadius / Ratio.skullRadiusMothOffset
        
         
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
       
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)
        
        let path = UIBezierPath()
        
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        
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
        color.set()
        pathSkull().stroke()
        pathForeye(.left).stroke()
        pathForeye(.right).stroke()
        pathForMouth().stroke()
    } 
}
