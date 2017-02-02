//
//  NewContactVC.swift
//  BestBrain
//
//  Created by anuradha on 1/30/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class NewContactVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet var txfFirstName: UITextField!
    @IBOutlet var txfLastName: UITextField!
    @IBOutlet var txfAddress: UITextField!
    @IBOutlet var txfCity: UITextField!
    @IBOutlet var txfState: UITextField!
    @IBOutlet var txfZipCode: UITextField!
    @IBOutlet var txfDOB: UITextField!
    @IBOutlet var txfDLState: UITextField!
    @IBOutlet var txfDLNumber: UITextField!

    @IBOutlet var vwTextFields: [UIView]!
    @IBOutlet var imgUser: UIImageView!

    @IBOutlet var tblAddItems: UITableView!
    
    var allItems = [addItems]()
    var index : Int = -1
    var textField = UITextField()
    
//    var arrPhones = [String]()
//    var arrEmails = [String]()
//    var arrDesiredVehicals = [String]()
//    var arrTrades = [String]()
//    var arrShare = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        txfFirstName.delegate = self
        txfLastName.delegate = self
        txfAddress.delegate = self
        txfCity.delegate = self
        txfState.delegate = self
        txfZipCode.delegate = self
        txfDOB.delegate = self
        txfDLState.delegate = self
        txfDLNumber.delegate = self

        txfFirstName.tag = -1
        txfLastName.tag = -1
        txfAddress.tag = -1
        txfCity.tag = -1
        txfState.tag = -1
        txfZipCode.tag = -1
        txfDOB.tag = -1
        txfDLState.tag = -1
        txfDLNumber.tag = -1

        self.loadData()
        tblAddItems.delegate = self
        tblAddItems.dataSource = self
        tblAddItems.register(UINib(nibName: "addItemCell", bundle: nil), forCellReuseIdentifier: "addItemCell")
        self.addDoneButtonOnKeyboard(textField: txfZipCode)
        self.addDoneButtonOnKeyboard(textField: txfDLNumber)
    }
    func loadData(){
        allItems = [
            addItems(name: "add phone", items: 1),
            addItems(name: "add email", items: 1),
            addItems(name: "add desired vehical", items: 1),
            addItems(name: "add trade", items: 1),
            addItems(name: "add source", items: 1)
        ]

    }
    override func viewDidAppear(_ animated: Bool) {
        for vw in vwTextFields{
            vw.layer.borderWidth = 1
            vw.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
            vw.layer.cornerRadius = 7
        }
        imgUser.layer.cornerRadius = imgUser.frame.size.width/2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return allItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allItems[section].collapsed!) ? 0 : allItems[section].items
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addItemCell", for: indexPath) as! addItemCell
        cell.txfCell.delegate = self
        cell.btnAddItem.tag = indexPath.section
        cell.txfCell.tag = indexPath.section

        if indexPath.section == 4{
            cell.btnAddItem.isHidden = true
        }else{
            cell.btnAddItem.isHidden = false
        }
        index = indexPath.row
        if indexPath.section == 0{
            addDoneButtonOnKeyboard(textField: cell.txfCell)
        }else{
        }

        cell.btnAddItem.addTarget(self, action: #selector(NewContactVC.btnAddItemClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        headerView.backgroundColor = UIColor.white
        let btn = UIButton(frame: headerView.frame)
        btn.tag = section
        let lblHeader = UILabel(frame: CGRect(x: 30, y: 5, width: headerView.frame.size.width-70, height: 40))
        lblHeader.text = allItems[section].name
        lblHeader.textColor = UIColor.blue
        btn.addTarget(self, action: #selector(NewContactVC.toggleButton), for: .touchUpInside)
        headerView.addSubview(btn)
        headerView.addSubview(lblHeader)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func toggleButton(_ sender: UIButton){
        let section = sender.tag
        let collapsed = allItems[section].collapsed
        
        // Toggle collapse
        allItems[section].collapsed = !collapsed!
        
        // Reload section
        tblAddItems.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    func btnAddItemClicked(_ sender: UIButton){
        let tag = sender.tag
        allItems[tag].items = allItems[tag].items+1
        tblAddItems.reloadData()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txfFirstName{
            txfFirstName.resignFirstResponder()
            txfLastName.becomeFirstResponder()
        }else if textField == txfLastName{
            txfLastName.resignFirstResponder()
            txfAddress.becomeFirstResponder()
        }else if textField == txfAddress{
            txfAddress.resignFirstResponder()
            txfCity.becomeFirstResponder()
        }else if textField == txfCity{
            txfCity.resignFirstResponder()
            txfState.becomeFirstResponder()
        }else if textField == txfState{
            if Appcheck_length(txfState.text!, length: 2, is_more: true){
                txfState.resignFirstResponder()
                txfZipCode.becomeFirstResponder()
            }else{
                print("Enter valid code.")
            }
        }
            //            else if textField == txfZipCode{
            //            txfZipCode.resignFirstResponder()
            //            txfDOB.becomeFirstResponder()
            //        }
        else if textField == txfDOB{
            txfDOB.resignFirstResponder()
            txfDLState.becomeFirstResponder()
        }else if textField == txfDLState{
            if Appcheck_length(txfDLState.text!, length: 2, is_more: true){
                txfDLState.resignFirstResponder()
                txfDLNumber.becomeFirstResponder()
            }else{
                print("Enter valid code.")
            }
        }
        //        else if textField == txfDLNumber{
        //            txfDLNumber.resignFirstResponder()
        //        }
        if textField.tag == 0{
        }else if textField.tag == 1{
            if self.Appcheck_email_address(textField.text!) == false{
                print("enter valid email Address.")
            }else{
                textField.resignFirstResponder()
            }
        }else if textField.tag == 2{
            //            textField.keyboardType = UIKeyboardType.default
        }else if textField.tag == 3{
            //            textField.keyboardType = UIKeyboardType.default
        }
        if textField == txfZipCode{
            self.addDoneButtonOnKeyboard(textField: txfZipCode)
        }else if textField == txfDLNumber{
            self.addDoneButtonOnKeyboard(textField: txfDLNumber)
        }
        
        tblAddItems.isScrollEnabled = true
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        if textField.tag == 0{
            textField.keyboardType = UIKeyboardType.numberPad
        }else if textField.tag == 1{
            textField.keyboardType = UIKeyboardType.emailAddress
        }else if textField.tag == 2{
            textField.keyboardType = UIKeyboardType.default
        }else if textField.tag == 3{
            textField.keyboardType = UIKeyboardType.default
        }
    }
    
    func addDoneButtonOnKeyboard(textField: UITextField)
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))//CGRectMake(0, 0, 320, 50)
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(NewContactVC.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.textField = textField
        textField.inputAccessoryView = doneToolbar
        
    }
    func doneButtonAction()
    {
        if self.textField.tag == 0{
            if Appcheck_number(self.textField.text!, length: 10){
                self.textField.resignFirstResponder()
            }else{
                print("enter valid phone number.")
            }
        }else{
            self.textField.resignFirstResponder()
        }
    }
    
    func Appcheck_zip_codes(_ data:String) -> Bool{
        let ns:NSString = "^([0-9]{5}|[A-Z][0-9][A-Z] ?[0-9][A-Z][0-9])$"
        let pr:NSPredicate = NSPredicate(format: "SELF MATCHES %@",ns)
        return pr.evaluate(with: data)
    }
    
    func Appcheck_email_address(_ data:String) -> Bool{
        let ns:NSString = "[A-Za-z0-9\\.]+@[A-Za-z0-9]+\\.[A-Za-z.]{2,6}"
        let pr:NSPredicate = NSPredicate(format: "SELF MATCHES %@",ns)
        return pr.evaluate(with: data)
    }
    func Appcheck_number(_ data:String,length:Int?) -> Bool{
        let ns:NSString
        if let _ = length{
            ns = "[0-9]{\(length!)}" as NSString
        }else{
            ns = "[0-9]+"
        }
        let pr:NSPredicate = NSPredicate(format: "SELF MATCHES %@",ns)
        return pr.evaluate(with: data)
    }
    
    func Appcheck_length(_ data:String,length:Int,is_more:Bool?) -> Bool{
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


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
extension UIViewController{
    func addToolBar(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(UIViewController.donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIViewController.cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    func donePressed(){
        view.endEditing(true)
    }
    func cancelPressed(){
        view.endEditing(true) // or do something
    }
}
