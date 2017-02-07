//
//  Constant.swift
//  BestBrain
//
//  Created by Suhani on 10/01/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width
let Screenheight = UIScreen.main.bounds.size.height

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let ZeroConstant: CGFloat = 0.0
let weatherApi = "https://api.darksky.net/forecast/e700e63b23dc86aa7f29a90be4c5fc2e/"


let textBoxColor = UIColor(colorLiteralRed: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
let dashboardBackgroundColor = UIColor(red: 0.08235294118, green: 0.3607843137, blue: 0.9294117647, alpha: 1.0)
let dashboardBottomColor = UIColor(red: 0.07843137255, green: 0.7882352941, blue: 0.9843137255, alpha: 1.0)
let whiteColor = UIColor.white

var TheCurrentDeviceVersion: Float {
    struct Singleton {
        static let deviceVersion = Float(UIDevice.current.systemVersion)
    }
    return Singleton.deviceVersion!
}

func iconColor(icon: UIImageView) -> UIImage {
    icon.image = icon.image!.withRenderingMode(.alwaysTemplate)
    icon.tintColor = whiteColor
    return icon.image!
}

func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
    let label: UILabel = UILabel(frame: CGRect(x: ZeroConstant, y: ZeroConstant, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.height
}

class callingStatus{
    var Status:Bool
    var Message:String
    var Request_Url:String
    init(Status:Bool,Message:String,Request_Url:String){
        self.Status = Status
        self.Message = Message
        self.Request_Url = Request_Url
    }
}

