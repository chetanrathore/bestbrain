//
//  LoginVC.swift
//  BestBrain
//
//  Created by chetanRathore on 10/01/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {

    
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet weak var vwUserName: UIView!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.txtUsername.delegate=self;
        self.txtPassword.delegate=self;
        
        btnLogin.layer.shadowColor = UIColor.darkGray.cgColor
        btnLogin.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        btnLogin.layer.shadowRadius = 5
        btnLogin.layer.shadowOpacity = 1.0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleLoginBtn(_ sender: Any) {
        let vc = DashboardVC(nibName: "DashboardVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func handleForgotPasswordBtn(_ sender: Any) {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag==1
        {
            vwUserName.layer.masksToBounds = false
            vwUserName.layer.shadowRadius = 3.0
            vwUserName.layer.shadowColor = UIColor.darkGray.cgColor
            vwUserName.layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
            vwUserName.layer.shadowOpacity = 1.0
        }else{
            vwPassword.layer.masksToBounds = false
            vwPassword.layer.shadowRadius = 3.0
            vwPassword.layer.shadowColor = UIColor.darkGray.cgColor
            vwPassword.layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
            vwPassword.layer.shadowOpacity = 1.0
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let myview = textField.superview
        myview?.layer.shadowOpacity = 0.0;
        return true;
    }
}
