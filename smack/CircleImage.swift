//
//  CircleImage.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/26/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {
    
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}
