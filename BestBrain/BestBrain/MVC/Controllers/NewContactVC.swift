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

    @IBOutlet var btnDLScan: UIButton!
    @IBOutlet var vwDesiredVehicle: UIView!
    @IBOutlet var scrollNewContact: UIScrollView!
    @IBOutlet var tblAddItems: UITableView!
    
    @IBOutlet var btnScanInventoryBikes: UIButton!
    @IBOutlet var lbDesiredVehicle: UILabel!
    @IBOutlet var searchbarDV: UISearchBar!
    @IBOutlet var txfYear: UITextField!
    @IBOutlet var txfMake: UITextField!
    @IBOutlet var txfModel: UITextField!
    @IBOutlet var txfModelNo: UITextField!
    @IBOutlet var btnSearch: UIButton!
    
    @IBOutlet var vwAddTrade: UIView!
    @IBOutlet var btnScanTrade: UIButton!
    @IBOutlet var txtFieldVIN: UITextField!
    @IBOutlet var txtFieldYear: UITextField!
    @IBOutlet var txtFieldMake: UITextField!
    @IBOutlet var txtFieldModel: UITextField!
    @IBOutlet var txtFieldMiles: UITextField!
    @IBOutlet var txtFieldPayoff: UITextField!
    @IBOutlet var btnAddManually: UIButton!
  
    @IBOutlet var btnLink: UIButton!
    @IBOutlet var btnAddCustomer: UIButton!
    
    @IBOutlet var vwMatch: UIView!
    @IBOutlet var imgMatchedUser: UIImageView!
   
    @IBOutlet var lbOR: UILabel!
    
    @IBOutlet var vwTxfCrnditInfo: [UIView]!
    @IBOutlet var vwCreditInfo: UIView!
    var allItems = [addItems]()
    var index : Int = -1
    var textField = UITextField()
   
    var Details = NSMutableDictionary()
    var cView: UIView!
    var transperentView = UIView()
    var isFromScanning:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false

        self.title = "New Contact"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.handleBtnSearch))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.handleBtnSearch))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewContactVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewContactVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        txfFirstName.delegate = self
        txfLastName.delegate = self
        txfAddress.delegate = self
        txfCity.delegate = self
        txfState.delegate = self
        txfZipCode.delegate = self
        txfDOB.delegate = self
        txfDLState.delegate = self
        txfDLNumber.delegate = self

        if isFromScanning{
            guard let userDetails  = Details["userData"] as? NSDictionary else {
            return
            }
            txfFirstName.text = userDetails.value(forKey: "Customer First Name") as? String
            txfLastName.text = userDetails.value(forKey: "Customer Family Name") as? String
            txfAddress.text = userDetails.value(forKey: "Address - Street 1") as? String
            txfCity.text = userDetails.value(forKey: "Address - City") as? String
            txfState.text = userDetails.value(forKey: "Address - Jurisdiction Code") as? String
            txfZipCode.text = userDetails.value(forKey: "Address - Postal Code") as? String
            var dob = (userDetails.value(forKey: "Date of Birth") as! String).insert(string: "/", ind: 2)
            dob = dob.insert(string: "/", ind: 5)
            txfDOB.text = dob
            txfDLState.text = nil
            txfDLNumber.text = nil
        btnDLScan.isHidden = true
        }else{
        btnDLScan.isHidden = false
        }
        self.loadData()
        tblAddItems.delegate = self
        tblAddItems.dataSource = self
        tblAddItems.register(UINib(nibName: "addItemCell", bundle: nil), forCellReuseIdentifier: "addItemCell")
        tblAddItems.register(UINib(nibName: "PreferredContentCell", bundle: nil), forCellReuseIdentifier: "PreferredContentCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       // NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        for vw in vwTextFields{
            vw.layer.borderWidth = 1
            vw.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
            vw.layer.cornerRadius = 7
        }
        for vw in vwTxfCrnditInfo{
            vw.layer.borderWidth = 1
            vw.layer.borderColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1).cgColor
            vw.layer.cornerRadius = 5
        }
        
        imgUser.layer.cornerRadius = imgUser.frame.size.width/2

        if ((Screenheight/2)-230) < 64{
            vwDesiredVehicle.frame = CGRect(x: 20, y: 65, width: ScreenWidth - 40, height: 450)
            vwCreditInfo.frame = CGRect(x: 20, y: 65, width: ScreenWidth - 40, height: 460)
            self.vwAddTrade.frame = CGRect(x: 20, y: 65, width: ScreenWidth - 40, height: self.vwAddTrade.frame.size.height)

        }else{
            vwDesiredVehicle.frame = CGRect(x: 20, y: (Screenheight/2)-225, width: ScreenWidth - 40, height: 450)
            vwCreditInfo.frame = CGRect(x: 20, y: (Screenheight/2)-230, width: ScreenWidth - 40, height: 460)
            self.vwAddTrade.frame = CGRect(x: 20, y: self.view.center.y - self.vwAddTrade.frame.size.height/2, width: ScreenWidth - 40, height: self.vwAddTrade.frame.size.height)

        }
        vwMatch.frame = CGRect(x: (ScreenWidth/2)-155, y: (Screenheight/2)-95, width: 310, height: 190)

        vwMatch.layer.borderColor = UIColor.lightGray.cgColor
        vwMatch.layer.borderWidth = 1.0
        vwMatch.layer.cornerRadius = 7
        
        vwCreditInfo.layer.borderColor = UIColor.lightGray.cgColor
        vwCreditInfo.layer.borderWidth = 1.0

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- TableView Method(s)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (allItems[section].collapsed!) ? 0 : allItems[section].items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreferredContentCell", for: indexPath) as! PreferredContentCell
            cell.btnPhone.tag = 101
            cell.btnPhone.addTarget(self, action: #selector(NewContactVC.handleViews(_:)), for: .touchUpInside)
            cell.btnEmail.tag = 102
            cell.btnEmail.addTarget(self, action: #selector(NewContactVC.handleViews(_:)), for: .touchUpInside)
            cell.btnSms.tag = 103
            cell.btnSms.addTarget(self, action: #selector(NewContactVC.handleViews(_:)), for: .touchUpInside)

            return cell
        }else{
        
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
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        headerView.backgroundColor = UIColor.white
        let btn = UIButton(frame: headerView.frame)
        btn.tag = section
        let lblHeader = UILabel(frame: CGRect(x: 50, y: 5, width: headerView.frame.size.width-120, height: 40))
        
        let imgPlus = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        imgPlus.image = UIImage(named: "plusFilledGreen.png")
        let imgArrow = UIImageView(frame: CGRect(x: headerView.frame.size.width-30, y: 15, width: 20, height: 20))
        let imgName = (allItems[section].collapsed!) ? "rightArrow" : "downArrow"

        imgArrow.image = UIImage(named: imgName)
        
        lblHeader.text = allItems[section].name
        lblHeader.textColor = UIColor(red: 57/255, green: 149/255, blue: 242/255, alpha: 1.0)
        btn.addTarget(self, action: #selector(NewContactVC.toggleButton), for: .touchUpInside)
        let borderView = UIView(frame: CGRect(x: 15, y: headerView.frame.size.height-1, width: headerView.frame.size.width-30, height: 1))
        borderView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        headerView.addSubview(btn)
        headerView.addSubview(lblHeader)
        headerView.addSubview(imgPlus)
        headerView.addSubview(imgArrow)
        headerView.addSubview(borderView)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 5{
            return 60
        }else{
            return 40
        }
    }
    // MARK:- TextField Delegate Method(s)
    
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
        if textField == txfZipCode{
            self.addDoneButtonOnKeyboard(textField: txfZipCode)
        }else if textField == txfDLNumber{
        self.addDoneButtonOnKeyboard(textField: txfDLNumber)
        }
        tblAddItems.isScrollEnabled = false
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
    
    // MARK:- TextField validation Method(s)
    
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
    // MARK:- Custom Method(s)
    func handleViews(_ sender: UIButton){
        if sender.tag == 101{
            
            generateSubView(childView: vwCreditInfo)
        }else if sender.tag == 102{
            
        }else if sender.tag == 103{
            
        }
        
    }
    func toggleButton(_ sender: UIButton){
        let section = sender.tag
        if section == 2{
            generateSubView(childView: self.vwDesiredVehicle)
        }else if section == 3{
            generateSubView(childView: self.vwAddTrade)
        }else{
            let collapsed = allItems[section].collapsed
            
            // Toggle collapse
            allItems[section].collapsed = !collapsed!
            // Reload section
            tblAddItems.reloadSections(IndexSet(integer: section), with: .automatic)
            if section == 5{
                if allItems[5].collapsed == false{
                    tblAddItems.scrollToRow(at: IndexPath(row: 0, section: 5), at: .bottom, animated: true)
                }
            }

        }
    }

    func generateSubView(childView: UIView) {
        self.transperentView = UIView(frame: UIScreen.main.bounds)
        self.transperentView.backgroundColor = transparentBackgroundColor
        if !self.view.subviews.contains(self.transperentView) {
            self.view.addSubview(self.transperentView)
        }
        view.addSubview(childView)
        self.cView = childView
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler))
        tap.cancelsTouchesInView = false
        self.transperentView.addGestureRecognizer(tap)
    }
    
    func tapHandler(){
        if self.view.subviews.contains(self.cView){
            self.cView.removeFromSuperview()
        }
        if self.view.subviews.contains(transperentView){
            transperentView.removeFromSuperview()
        }
    }
    
    func btnAddItemClicked(_ sender: UIButton){
        let tag = sender.tag
        allItems[tag].items = allItems[tag].items+1
        tblAddItems.reloadData()
    }
    
    func addDoneButtonOnKeyboard(textField: UITextField)
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 50))
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
    
    func doneButtonAction(txt: UITextField)
    {
        if self.textField.tag == 0{
            if Appcheck_number(self.textField.text!, length: 10){
                tblAddItems.isScrollEnabled = true
                self.textField.resignFirstResponder()
            }else{
                print("enter valid phone number.")
            }
        }else{
            
            if self.textField.tag == 16{
                if Appcheck_zip_codes(self.textField.text!) == true{
                    self.textField.resignFirstResponder()
                }else{
                    print("enter valid zip code.")
                }
            }else if self.textField.tag == 19{
                //                if Appcheck_zip_codes(self.textField.text!) == true{
                self.textField.resignFirstResponder()
                //                }else{
                //                    print("enter valid DL NUMBER.")
                //                }
            }
        }
    }
    func keyboardWillShow(notification: NSNotification){
        
    }
    func keyboardWillHide(notification: NSNotification){
        tblAddItems.isScrollEnabled = true
    }
    
    func loadData(){
        allItems = [
            addItems(name: "add phone", items: 1),
            addItems(name: "add email", items: 1),
            addItems(name: "add desired vehical", items: 0),
            addItems(name: "add trade", items: 0),
            addItems(name: "add source", items: 0),
            addItems(name: "add 5 liner", items: 1)
        ]
    }
    func loadTextFields(notification: NSNotification){
        
        
        guard let userInfo:NSDictionary = notification.object as! NSDictionary? ,
            let userDetails  = userInfo["userData"] as? NSDictionary
         //   let hideBtn     = userInfo["hideBtn"]    as? Bool
        else
        {
            return
        }

            txfFirstName.text = userDetails.value(forKey: "Customer First Name") as? String
            txfLastName.text = userDetails.value(forKey: "Customer Family Name") as? String
        txfAddress.text = userDetails.value(forKey: "Address - Street 1") as? String
            txfCity.text = userDetails.value(forKey: "Address - City") as? String
            txfState.text = userDetails.value(forKey: "Address - Jurisdiction Code") as? String
            txfZipCode.text = userDetails.value(forKey: "Address - Postal Code") as? String
            var dob = (userDetails.value(forKey: "Date of Birth") as! String).insert(string: "/", ind: 2)
            dob = dob.insert(string: "/", ind: 5)
            txfDOB.text = dob
            txfDLState.text = nil
            txfDLNumber.text = nil
            btnDLScan.isHidden = true

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "extractedData"), object: nil)
    }
    // MARK:- IBOutlet Method(s)
    
    @IBAction func handleBtnLinkToCustomer(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "relationLinked"), object: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleBtnAddCustomer(_ sender: Any) {
        generateSubView(childView: vwMatch)
    }
    
    @IBAction func handleBtnDLScan(_ sender: Any) {
        let vc = DLScanCameraVC(nibName: "DLScanCameraVC", bundle: nil)
        vc.isFromDashBoard = false
        vc.isFromDLScan = true
        vc.isFromVINScan = false
        NotificationCenter.default.addObserver(self, selector: #selector(NewContactVC.loadTextFields(notification:)), name: NSNotification.Name(rawValue: "extractedData"), object: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func handleBtnScanInventory(_ sender: Any) {
        let vc = DLScanCameraVC(nibName: "DLScanCameraVC", bundle: nil)
        vc.isFromDashBoard = false
        vc.isFromDLScan = false
        vc.isFromVINScan = true
       // NotificationCenter.default.addObserver(self, selector: #selector(NewContactVC.loadTextFields(notification:)), name: NSNotification.Name(rawValue: "extractedData"), object: nil)
        self.present(vc, animated: true, completion: nil)

    }
    @IBAction func handleBtnSearch(_ sender: Any) {
    }
    @IBAction func handleBtnAddManually(_ sender: Any) {
    }
    
    @IBAction func handleBtnScanTrade(_ sender: Any) {
        let vc = DLScanCameraVC(nibName: "DLScanCameraVC", bundle: nil)
        vc.isFromDashBoard = false
        vc.isFromDLScan = false
        vc.isFromVINScan = true
       // NotificationCenter.default.addObserver(self, selector: #selector(NewContactVC.loadTextFields(notification:)), name: NSNotification.Name(rawValue: "extractedData"), object: nil)
        self.present(vc, animated: true, completion: nil)
    }

    
}



