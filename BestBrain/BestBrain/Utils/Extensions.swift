//
//  Extensions.swift
//  BestBrain
//
//  Created by sparth on 1/30/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
 
    func setTintColor(color : UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
    
}

extension UIView {
    
    func gradientLayer() {
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.frame.size = CGSize(width: ScreenWidth, height: Screenheight)
        let blue = UIColor(colorLiteralRed: 21/255, green: 94/255, blue: 237/255, alpha: 1).cgColor
        let lightBlue = UIColor(colorLiteralRed: 20/255, green: 201/255, blue: 251/255, alpha: 1).cgColor
        gradiantLayer.colors = [blue, lightBlue, lightBlue]
        self.layer.addSublayer(gradiantLayer)
    }

}
