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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var vwBack: UIView!
    @IBOutlet var imgBottom: UIImageView!
    @IBOutlet var imgAppLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.txtUsername.delegate=self
        self.txtPassword.delegate=self
        
        btnLogin.layer.shadowColor = UIColor.darkGray.cgColor
        btnLogin.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        btnLogin.layer.shadowRadius = 5
        btnLogin.layer.shadowOpacity = 1.0
        
        self.activityIndicator.isHidden = false
        self.vwBack = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: Screenheight))
        self.vwBack.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.view.addSubview(vwBack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.evo_drawerController?.navigationController?.navigationBar.isHidden = true
        self.view.gradientLayer()
        self.view.bringSubview(toFront: self.txtPassword)
        self.view.bringSubview(toFront: self.txtUsername)
        self.view.bringSubview(toFront: self.btnLogin)
        self.view.bringSubview(toFront: self.btnForgetPassword)
        self.view.bringSubview(toFront: self.imgBottom)
        self.view.bringSubview(toFront: self.imgAppLogo)
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
            Customs.showAlert(msg: "Email id and password must be required.")
        }else if(!isValidEmail(strEmail: strUserName)) {
            Customs.showAlert(msg: "Invalid email address.")
        }else if(!isValidPassword(strPassword: strPassword)) {
            Customs.showAlert(msg: "Password must contain at least 8 characters.")
        }else {
            self.activityIndicator.isHidden = false
            self.btnLogin.isEnabled = false
            self.view.bringSubview(toFront: self.vwBack)
            self.view.bringSubview(toFront: self.activityIndicator)
            var loginData = [String:String]()
            loginData["email"] = self.txtUsername.text
            loginData["password"] = self.txtPassword.text
            ServerAPI.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: "auth/local", Str_Request_Method: "POST", Request_parameter: loginData, Request_parameter_Images: nil, isTokenEmbeded: false, status: { (status) in
            }, response_Dictionary: { (result) in
                DispatchQueue.main.async {
                    self.btnLogin.isEnabled = true
                    self.activityIndicator.isHidden = true
                    self.view.sendSubview(toBack: self.vwBack)
                    self.view.sendSubview(toBack: self.activityIndicator)
                    if result.object(forKey: "message") != nil {
                        let message = (result.object(forKey: "message") as? String)!
                        Customs.showAlert(msg: message)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUsername{
            txtUsername.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }else if textField == txtPassword{
            txtPassword.resignFirstResponder()
        }
        return true
    }

}
