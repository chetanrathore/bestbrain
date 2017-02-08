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
        gradiantLayer.colors = [dashboardBackgroundColor.cgColor, dashboardBottomColor.cgColor, dashboardBottomColor.cgColor]
        self.layer.addSublayer(gradiantLayer)
    }

}
