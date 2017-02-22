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
let transparentBackgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.1)
let whiteColor = UIColor.white

class addItems{
    var name: String!
    var items: Int!
    var collapsed: Bool!
    
    init(name: String, items: Int, collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}


var TheCurrentDeviceVersion: Float {
    struct Singleton {
        static let deviceVersion = Float(UIDevice.current.systemVersion)
    }
    return Singleton.deviceVersion!
}

func iconColor(icon: UIImageView) -> UIImage {
    icon.image = icon.image!.withRenderingMode(.alwaysTemplate)
    icon.tintColor = UIColor.black
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

//validation
func isvalidZipCodes(_ data:String) -> Bool{
    let ns:NSString = "^([0-9]{5}|[A-Z][0-9][A-Z] ?[0-9][A-Z][0-9])$"
    let pr:NSPredicate = NSPredicate(format: "SELF MATCHES %@",ns)
    return pr.evaluate(with: data)
}


func isValidNumber(_ data:String,length:Int?) -> Bool{
    let ns:NSString
    if let _ = length{
        ns = "[0-9]{\(length!)}" as NSString
    }else{
        ns = "[0-9]+"
    }
    let pr:NSPredicate = NSPredicate(format: "SELF MATCHES %@",ns)
    return pr.evaluate(with: data)
}

func isValidLength(_ data:String,length:Int,is_more:Bool?) -> Bool{
    if data.isEmpty{
        return false
    }
    if let _ = is_more{
        if is_more == true{
            if data.characters.count >= length{
                return true
            }else{
                return false
            }
        }
    }
    if data.characters.count == length{
        return true
    }else{
        return false
    }
}

func isValidEmail(strEmail : String) ->  Bool
{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: strEmail)
}

func isValidPassword(strPassword : String) -> Bool
{
    let totalChar = strPassword.characters.count
    return totalChar > 4
}
class Customs{
    static func showAlert(msg:String){
        let alert = UIAlertView(title: "WARNING", message: msg, delegate: self, cancelButtonTitle: "ok")
        alert.show()
    }
}
