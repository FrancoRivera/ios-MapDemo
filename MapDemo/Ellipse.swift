//
//  Ellipse.swift
//  MapDemo
//
//  Created by Franco Rivera on 8/24/18.
//  Copyright © 2018 Franco Rivera. All rights reserved.
//

import Foundation
import UIKit



class Ellipse{
    
    func getPath() -> UIBezierPath{
        let radius: CGFloat = 20
        let center = CGPoint(x: 230, y: 100)
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(Double.pi), endAngle: -CGFloat(Double.pi/2), clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(Double.pi/2), endAngle: 0, clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: true)
        circlePath.close()
        return circlePath
    }
    
}
