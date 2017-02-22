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

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

extension String {
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}

extension UIView {
    
    func gradientLayer() {
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.frame.size = CGSize(width: ScreenWidth, height: Screenheight)
        gradiantLayer.colors = [dashboardBackgroundColor.cgColor, dashboardBottomColor.cgColor]
        self.layer.addSublayer(gradiantLayer)
    }

}

extension UISegmentedControl {
    func removeBorders() {
    
//        setBackgroundImage(imageWithColor(color: UIColor.clear), for: .normal, barMetrics: .default)
//        setBackgroundImage(imageWithColor(color: UIColor.red), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    
    }
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 15.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
