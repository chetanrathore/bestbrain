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
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet var btnForgetPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.txtUsername.delegate=self
        self.txtPassword.delegate=self
        
        btnLogin.layer.shadowColor = UIColor.darkGray.cgColor
        btnLogin.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        btnLogin.layer.shadowRadius = 5
        btnLogin.layer.shadowOpacity = 1.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.gradientLayer()
        self.view.bringSubview(toFront: self.txtPassword)
        self.view.bringSubview(toFront: self.txtUsername)
        self.view.bringSubview(toFront: self.btnLogin)
//        self.view.bringSubview(toFront: self.btnForgetPassword)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- IBOutlet Method(s)

    @IBAction func handleLoginBtn(_ sender: Any) {
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
        let strUserName = txtUsername.text!
        let strPassword = txtPassword.text!
        
        if (strUserName.isEmpty || strPassword.isEmpty) {
            displayAlertMessage(alertMessage: "Email id and password must be required.")
        }else if(!isValidEmail(strEmail: strUserName)) {
            displayAlertMessage(alertMessage: "Invalid email address.")
        }else if(!isValidPassword(strPassword: strPassword)) {
            displayAlertMessage(alertMessage: "Password must contain at least 8 characters")
        }else {
            var loginData = [String:String]()
            loginData["email"] = self.txtUsername.text
            loginData["password"] = self.txtPassword.text
            ServerAPI.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: "auth/local", Str_Request_Method: "POST", Request_parameter: loginData, Request_parameter_Images: nil, isTokenEmbeded: false, status: { (status) in
            }, response_Dictionary: { (result) in
                DispatchQueue.main.async {
                    if result.object(forKey: "message") != nil {
                        let message = (result.object(forKey: "message") as? String)!
                        self.displayAlertMessage(alertMessage: message)
                    }
                    if result.object(forKey: "token") != nil {
                        let token = result.object(forKey: "token") as? String
                        ServerAPI.tocken = token
                        let vc = CustomerDashboardVC(nibName: "CustomerDashboardVC", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }, response_Array: { (result) in
            })
        }
    }
    
    @IBAction func handleForgotPasswordBtn(_ sender: Any) {
    }
    
    
    // MARK:- Text Field Method(s)
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let myview = textField.superview
        myview?.layer.shadowOpacity = 0.0;
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.txtUsername{
            txtUsername.layer.masksToBounds = false
            txtUsername.layer.shadowRadius = 3.0
            txtUsername.layer.shadowColor = UIColor.darkGray.cgColor
            txtUsername.layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
            txtUsername.layer.shadowOpacity = 1.0
            
            txtPassword.layer.shadowRadius = 3.0
            txtPassword.layer.shadowColor = UIColor.clear.cgColor
            txtPassword.layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
            txtPassword.layer.shadowOpacity = 1.0
        } else {
            txtPassword.layer.masksToBounds = false
            txtPassword.layer.shadowRadius = 3.0
            txtPassword.layer.shadowColor = UIColor.darkGray.cgColor
            txtPassword.layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
            txtPassword.layer.shadowOpacity = 1.0
            
            txtUsername.layer.shadowRadius = 3.0
            txtUsername.layer.shadowColor = UIColor.clear.cgColor
            txtUsername.layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
            txtUsername.layer.shadowOpacity = 1.0
        }
    }

    
    // MARK:- Custom method(s)
    
    func displayAlertMessage(title: String = "Oops!",alertMessage:String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
