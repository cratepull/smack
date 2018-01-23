//
//  GradientView.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/22/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit


@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var topColor = #colorLiteral(red: 0.3631127477, green: 0.4045833051, blue: 0.8775706887, alpha: 1){
        didSet {
            
            self.setNeedsLayout()
        
        }
    }
    
    
    @IBInspectable var buttonColor =  #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1){
        didSet {
            self.setNeedsLayout()
            
        }
    }
    
    override func layoutSubviews() {
        let gradintLayer  = CAGradientLayer()
        
        gradintLayer.colors = [topColor.cgColor, buttonColor.cgColor]
        gradintLayer.startPoint = CGPoint(x: 0, y: 0)
        gradintLayer.endPoint = CGPoint(x: 1, y: 1)
        gradintLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradintLayer, at: 0)
        
    }
}
