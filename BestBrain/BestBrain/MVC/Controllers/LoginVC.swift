//
//  LoginVC.swift
//  BestBrain
//
//  Created by Devloper30 on 10/01/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

}
