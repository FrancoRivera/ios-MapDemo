//
//  Block.swift
//  MapDemo
//
//  Created by Franco Rivera on 8/24/18.
//  Copyright © 2018 Franco Rivera. All rights reserved.
//

import Foundation
import UIKit

class Block{
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    var isHidden: Bool = true;
    var view: UIView = UIView()
//    var layer: CAShapeLayer = CAShapeLayer()
    var old_width: CGFloat = 0
    var old_height: CGFloat = 0
    var old_factor: CGFloat = 0
    
    init(x:CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.x = x
        self.y = y
        
        self.height = height
        self.width = width
        
        old_width = width
        old_height = height
        
        self.view.layer.cornerRadius = 5
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fill2)))
        
//        view.layer.addSublayer(layer)
//        layer.path = self.getPath().cgPath
//        layer.fillColor = UIColor.white.cgColor
//        layer.strokeColor = UIColor.black.cgColor
//        layer.lineWidth = 0.1

        
    }
    func move(direction:String){
        self.x += 20
//         layer.path = self.getPath().cgPath
    }
    func scale(factor: CGFloat, point: CGPoint){
        self.height = self.old_height * factor
        self.width = self.old_width * factor
        
        var dist = sqrt(pow((self.x - point.x), 2) + pow((self.y - point.y), 2))
        
//        print(factor)
        var d_x = self.x - point.x // if negative move to right
        var d_y = self.y - point.y // if negative move to bottom
        
//        0..1 zoom out
//        1..2 zoom in
        
        
        d_x /= 40
        d_y /= 40
        
        if factor > old_factor{
            if d_x > 0{
                 self.x += d_x
            }
            if d_x < 0{
                self.x += d_x
            }
            if d_y > 0{
                self.y += d_y
            }
            if d_y < 0{
                  self.y += d_y
            }
            
        
        }else{
            if d_x > 0{
                self.x -= d_x
            }
            if d_x < 0{
                self.x -= d_x
            }
            if d_y > 0{
                self.y -= d_y
            }
            if d_y < 0{
                self.y -= d_y
            }
        }
        old_factor = factor
       
//        self.y += factor / d_y
        
//        layer.path = self.getPath().cgPath
    }

    @objc func fill2(){
        if self.isHidden{
            self.view.backgroundColor = UIColor(displayP3Red: 1/(self.x/100), green: 1/(self.y/100), blue: (self.y/100), alpha: 1)
            self.isHidden = false
        }else{
                self.view.backgroundColor = UIColor.white
                self.isHidden = true
            }
            
        }
    
    @objc func fill(gesture: String){
        if self.isHidden{
            self.view.backgroundColor = UIColor(displayP3Red: 1/(self.x/100), green: 1/(self.y/100), blue: (self.y/100), alpha: 1)
            self.isHidden = false
        }else{
            if gesture == "tap"{
                self.view.backgroundColor = UIColor.white
                self.isHidden = true
            }
           
        }
    }
    
}
