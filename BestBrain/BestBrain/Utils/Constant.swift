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
let weatherApi = "https://api.darksky.net/forecast/e700e63b23dc86aa7f29a90be4c5fc2e/"

let textBoxColor = UIColor(colorLiteralRed: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)

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
