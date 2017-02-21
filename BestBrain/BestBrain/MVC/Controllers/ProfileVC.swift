//
//  ProfileVC.swift
//  BestBrain
//
//  Created by Suhani on 16/02/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var btnProfile: UIButton!
    
    @IBOutlet var lblFName: UILabel!
    @IBOutlet var txtFname: UITextField!
    
    @IBOutlet var lblMName: UILabel!
    @IBOutlet var txtMname: UITextField!
    
    @IBOutlet var lblLName: UILabel!
    @IBOutlet var txtLname: UITextField!
    
    @IBOutlet var lblNickName: UILabel!
    @IBOutlet var txtNickName: UITextField!
    
    @IBOutlet var lblPosition: UILabel!
    @IBOutlet var txtPosition: UITextField!
    
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var txtUserId: UITextField!
    
    @IBOutlet var lblPwd: UILabel!
    @IBOutlet var txtPwd: UITextField!
    
    @IBOutlet var lblDMSId: UILabel!
    @IBOutlet var txtDMSid: UITextField!
    
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var txtEmail: UITextField!
    
    @IBOutlet var lblCell: UILabel!
    @IBOutlet var txtCell: UITextField!
    
    @IBOutlet var lblDirect: UILabel!
    @IBOutlet var txtDirect: UITextField!
    
    var imagePicker = UIImagePickerController()
    var isEditable = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.setTextFieldDelegate()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.evo_drawerController?.navigationController?.navigationBar.isHidden = false

        if self.isEditable{
            self.isEditable = false
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handleDoneBtn))
          //  self.navigationItem.setRightBarButton(doneBtn, animated: true)
        
            self.navigationItem.rightBarButtonItem = doneBtn
        } else {
            self.isEditable = true
            let editBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.handleEditBtn))
           // self.navigationItem.setRightBarButton(editBtn, animated: true)
            self.navigationItem.rightBarButtonItem = editBtn

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- ImagePicker Delegate Method(s)
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.btnProfile.contentMode = .scaleAspectFit
        self.btnProfile.setImage(chosenImage, for: .normal)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- TextField Method(s)
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isEditable {
            self.setEnableTextField()
        } else {
            self.disableTextField()
        }
    }
    
    // MARK:- IBOutlet Method(s)
    
    @IBAction func handleBtnProfile(_ sender: Any) {
        self.handleEditBtn()
    }
    
    // MARK:- Custom Method(s)
    
    func handleEditBtn() {
        self.btnProfile.isEnabled = true
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
        self.imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func handleDoneBtn() {
        self.btnProfile.isEnabled = false
        self.imagePicker.delegate = nil
        
    }

    func setTextFieldDelegate() {
        self.txtFname.delegate = self
        self.txtMname.delegate = self
        self.txtLname.delegate = self
        self.txtNickName.delegate = self
        self.txtPosition.delegate = self
        self.txtUserId.delegate = self
        self.txtPwd.delegate = self
        self.txtDMSid.delegate = self
        self.txtEmail.delegate = self
        self.txtCell.delegate = self
        self.txtDirect.delegate = self
    }
    
    func setEnableTextField() {
        self.txtFname.isEnabled = true
        self.txtMname.isEnabled = true
        self.txtLname.isEnabled = true
        self.txtNickName.isEnabled = true
        self.txtPosition.isEnabled = true
        self.txtUserId.isEnabled = true
        self.txtPwd.isEnabled = true
        self.txtDMSid.isEnabled = true
        self.txtEmail.isEnabled = true
        self.txtCell.isEnabled = true
        self.txtDirect.isEnabled = true
    }
    
    func disableTextField()  {
        self.txtFname.isEnabled = false
        self.txtMname.isEnabled = false
        self.txtLname.isEnabled = false
        self.txtNickName.isEnabled = false
        self.txtPosition.isEnabled = false
        self.txtUserId.isEnabled = false
        self.txtPwd.isEnabled = false
        self.txtDMSid.isEnabled = false
        self.txtEmail.isEnabled = false
        self.txtCell.isEnabled = false
        self.txtDirect.isEnabled = false
    }
}
