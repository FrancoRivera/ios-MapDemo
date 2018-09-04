//
//  ViewController.swift
//  MapDemo
//
//  Created by Franco Rivera on 8/24/18.
//  Copyright © 2018 Franco Rivera. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import CoreLocation

class ViewController: UIViewController {
    let json: String = "Yolo"
    var map: [[Block]] = []
    var blocks: [Block] = []
    let blockWidth: CGFloat = 20
    let blockHeight:CGFloat = 20
    var timer = Timer()
    var factor:CGFloat = 1
    var myStack: UIStackView = UIStackView()
    var widthConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    var old_factor:CGFloat = 1;
    let locationManager = CLLocationManager()
    
//    var timer2: Timer? = nil
    @IBAction func scalePiece(_ sender: UIPinchGestureRecognizer) {
    
        UIView.animate(withDuration: 0.1, animations: {
            var width:CGFloat = self.myStack.frame.width
            var height:CGFloat = self.myStack.frame.height
            if self.old_factor != self.factor {
             width /= self.factor
             height /= self.factor
            }
            let new_width = (width*sender.scale)
            let new_height = (height*sender.scale)
            
            self.myStack.frame = CGRect(x: (self.mapView.frame.width-new_width)/2, y: (self.mapView.frame.height-(new_height))/2, width: new_width, height: new_height)
            self.mapView.clipsToBounds = true
            self.myStack.layoutIfNeeded()
            
        }, completion: nil)
        factor = sender.scale
        
        switch sender.state {
        case .began:
           print("began")
        case .ended:
             old_factor = factor
             factor = sender.scale
        case .cancelled:
            break
        default:
            break
        }
       
    }
    
    @IBOutlet weak var mapView: UIView!
    
    // Check for touches
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("nigga")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if touches.count >= 2 {
            //drag doesnt work work yet tho
            
            for i in 0..<Int(mapView.bounds.width/blockWidth){
                for j in 0..<Int(mapView.bounds.height/blockHeight){
                    map[i][j].move(direction: "right")
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("moving")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 0..<Int(mapView.bounds.width/blockWidth)+1{
            map.append([])
            for j in 0..<Int(mapView.bounds.height/blockHeight)+1{
                map[i].append(Block(x: CGFloat(CGFloat(i)*blockWidth), y: CGFloat(CGFloat(j)*blockHeight), width: blockWidth, height: blockHeight))
                
            }
        }
        var arregloStack: [UIStackView] = []

        for i in 0..<Int(mapView.bounds.width/blockWidth){
            var tempArray: [UIView] = []
            for j in 0..<Int(mapView.bounds.height/blockHeight){
                let newView = map[i][j].view
                newView.backgroundColor = UIColor.white
                tempArray.append(newView)
            }
            let arrStack = UIStackView(arrangedSubviews: tempArray)
            arrStack.alignment = .fill
            arrStack.axis = .vertical
            arrStack.distribution = .fillEqually
            
            arrStack.spacing = 2
            arregloStack.append(arrStack)
        }
        myStack = UIStackView(arrangedSubviews:arregloStack)

        myStack.frame = CGRect(x: 0, y: 0, width: mapView.frame.width, height: mapView.frame.height)
        myStack.alignment = .fill
        myStack.axis = .horizontal
        myStack.distribution = .fillEqually
        myStack.spacing = 2
        mapView.addSubview(myStack)
        
        
        widthConstraint = NSLayoutConstraint(item: myStack, attribute: .width, relatedBy: .equal, toItem: mapView, attribute: .width, multiplier: 1, constant: 0)
        heightConstraint = NSLayoutConstraint(item: myStack, attribute: .height, relatedBy: .equal, toItem: mapView, attribute: .height, multiplier: 1, constant: 0)
        let horizontalConstraint = NSLayoutConstraint(item: myStack, attribute: .centerX, relatedBy: .equal, toItem: mapView, attribute: .centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: myStack, attribute: .centerY, relatedBy: .equal, toItem: mapView, attribute: .centerY, multiplier: 1, constant: 0)
        mapView.addConstraints([horizontalConstraint, verticalConstraint, heightConstraint, widthConstraint])
        myStack.frame = mapView.bounds
        
       

        var panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveMap))
        panGesture.minimumNumberOfTouches = 2
        self.mapView.addGestureRecognizer(panGesture)
        
    
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
    }
    @objc func moveMap(sender: UIPanGestureRecognizer? = nil) {
        // handling code
        print()
        self.myStack.frame = CGRect(x: self.myStack.frame.minX+(sender?.velocity(in: self.view))!.x/40, y: self.myStack.frame.minY+(sender?.velocity(in: self.view))!.y/40, width: self.myStack.frame.width, height: self.myStack.frame.height)
    
    }
    
    
    @objc func updateMap(){
            //do stuff
    }


}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")

    }
}

