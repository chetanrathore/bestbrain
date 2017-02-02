//
//  LogCustomerVC.swift
//  BestBrain
//
//  Created by chetanRathore on 10/01/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class LogCustomerVC: UIViewController {

    
    @IBOutlet var scrlView: UIScrollView!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtAddress: UITextField!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var txtZipCode: UITextField!
    @IBOutlet var txtState: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtDrivingLicense: UITextField!
    @IBOutlet var txtBirthDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }
    
    func setView(){
        txtFirstName.layer.borderColor = textBoxColor.cgColor
        txtLastName.layer.borderColor = textBoxColor.cgColor
        txtAddress.layer.borderColor = textBoxColor.cgColor
        txtCity.layer.borderColor = textBoxColor.cgColor
        txtZipCode.layer.borderColor = textBoxColor.cgColor
        txtState.layer.borderColor = textBoxColor.cgColor
        txtPhone.layer.borderColor = textBoxColor.cgColor
        txtEmail.layer.borderColor = textBoxColor.cgColor
        txtDrivingLicense.layer.borderColor = textBoxColor.cgColor
        txtBirthDate.layer.borderColor = textBoxColor.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleSearchBtn(_ sender: Any) {
    }

    @IBAction func btnMenuClicked(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)

    }
    
    
}
