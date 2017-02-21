//
//  CustomerVC.swift
//  BestBrain
//
//  Created by sparth on 2/7/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class CustomerVC: UIViewController,  UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var txtSearchBar: UISearchBar!
    @IBOutlet var tblCustomer: UITableView!
    @IBOutlet var btnNewCustomer: UIButton!
    @IBOutlet var btnAll: UIButton!
    @IBOutlet var btnActive: UIButton!
    @IBOutlet var btnInactive: UIButton!
    @IBOutlet var vwRelation: UIView!
    @IBOutlet var tblRelation: UITableView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnMenu: UIButton!
    
    var arrCustomer = [Customer]()
    var arrFilteredCustomers = [Customer]()
    var arrRelation = ["Mother", "Father", "Nephew", "Niece", "Husband", "Wife", "Brother", "Sister", "Daughter", "Son", "Grandfather", "Grandmother", "Uncle", "Aunt"]
    var isSearch: Bool = false
    var isLink = Bool()
    var transperentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        tblCustomer.tableFooterView = UIView()
        tblRelation.tableFooterView = UIView()
        tblRelation.dataSource = self
        tblRelation.delegate = self
        tblCustomer.dataSource = self
        txtSearchBar.delegate = self
        tblCustomer.delegate = self
        tblCustomer.register(UINib(nibName: "CustomerCell", bundle: nil), forCellReuseIdentifier: "CustomerCell")
        tblRelation.register(UINib(nibName: "RelationCell", bundle: nil), forCellReuseIdentifier: "relationCell")
        //Temporary data
        let customer1 = Customer(firstName: "John", lastName: "other details", city: "New York")
        let customer2 = Customer(firstName: "tmp", lastName: "xcvxcv", city: "New York")
        let customer3 = Customer(firstName: "John Khan", lastName: "Xyvxcvz", city: "New York")
        let customer4 = Customer(firstName: "John", lastName: "Xy45646z", city: "New York")
        let customer5 = Customer(firstName: "Jotmphn", lastName: "Xy6565z", city: "New York")
        let customer6 = Customer(firstName: "Abcd", lastName: "Xytyty56fgz", city: "New York")
        
        arrCustomer.append(customer1)
        arrCustomer.append(customer2)
        arrCustomer.append(customer3)
        arrCustomer.append(customer4)
        arrCustomer.append(customer5)
        arrCustomer.append(customer6)
        
        var textfield = UITextField()
        let searchViews = txtSearchBar.subviews
        for i in 0..<searchViews.count{
            if searchViews[i] .isKind(of: UITextField.self){
                searchViews[i].backgroundColor = UIColor.blue
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLink), name: NSNotification.Name(rawValue: "relationLinked"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.popRelationView), name: NSNotification.Name(rawValue: "LinkRelationship"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
//        self.evo_drawerController?.navigationController?.navigationBar.isHidden = true
       // self.navigationController?.navigationBar.isHidden = true
        if !(txtSearchBar.text?.isEmpty)! {
            isSearch = true
            self.tblCustomer.reloadData()
        } else {
            self.tblCustomer.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if txtSearchBar.isFirstResponder {
            txtSearchBar.resignFirstResponder()
        }
    }
    
    override func viewDidLayoutSubviews() {
        if ((Screenheight/2)-230) < 64{
            vwRelation.frame = CGRect(x: 20, y: 65, width: ScreenWidth - 40, height: 450)
            self.vwRelation.frame = CGRect(x: 20, y: 65, width: ScreenWidth - 40, height: self.vwRelation.frame.size.height)
        }else{
            vwRelation.frame = CGRect(x: 20, y: (Screenheight/2)-225, width: ScreenWidth - 40, height: 450)
            self.vwRelation.frame = CGRect(x: 20, y: self.view.center.y - self.vwRelation.frame.size.height/2, width: ScreenWidth - 40, height: self.vwRelation.frame.size.height)
        }
    }
    
    // MARK:- TableView Method(s)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblCustomer {
            if isSearch {
                if arrFilteredCustomers.count == 0 {
                    alertView(message: "No Such Customer Found.")
                }else {
                    //                vwBackground.isHidden = false
                }
                return arrFilteredCustomers.count
            }else {
                if arrCustomer.count == 0 {
                    //                vwBackground.isHidden = true
                    alertView(message: "No Customer Found.")
                }else {
                    //                vwBackground.isHidden = false
                }
                return arrCustomer.count
            }
        } else {
            return self.arrRelation.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tblCustomer {
            var customer = Customer()
            
            if isSearch {
                if self.arrFilteredCustomers.count > 0{
                    customer = self.arrFilteredCustomers[indexPath.row]
                }else{
                    customer = self.arrCustomer[indexPath.row]
                }
            }else {
                customer = self.arrCustomer[indexPath.row]
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath) as! CustomerCell
            if self.isLink {
                cell.btnCheckbox.isHidden = false
            } else {
                cell.btnCheckbox.isHidden = true
            }
            
            cell.imgCustomer.image = UIImage(named: "user.png")
            cell.setCellInterface()
            // cell.lblCustomerName.text = customer.firstName
            cell.backgroundColor = UIColor.clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "relationCell", for: indexPath) as! RelationCell
            cell.lblRelation.text = self.arrRelation[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tblCustomer {
        } else {
            let cell = tableView.cellForRow(at: indexPath) as! RelationCell
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == self.tblRelation {
            let cell = tableView.cellForRow(at: indexPath) as! RelationCell
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let more = UITableViewRowAction(style: .normal, title: "Add") { (action, indexPath) in
            let vc = NewContactVC(nibName: "NewContactVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
//                more.backgroundColor = UIColor(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 0.0)
                more.backgroundColor = UIColor(patternImage: self.imageWithImage(#imageLiteral(resourceName: "add.png"), scaledToSize: CGSize(width: 50, height: 50)))
        
        return [more]
    }
    
    
    
    // MARK:- Search Bar Delegate(s)
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
        self.txtSearchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.isSearch = false
            tblCustomer.reloadData()
        }else {
            let text = searchText.trimmingCharacters(in: .whitespaces)
            if !text.isEmpty {
                self.isSearch = true
                filterCustomers(str: text)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if isSearch == true{
            isSearch = false
            tblCustomer.reloadData()
        }
        self.txtSearchBar.showsCancelButton = false
        self.txtSearchBar.endEditing(true)
    }
    
    // MARK:- Custom Method(s)
    
    func updateLink(notification: NSNotification) {
        self.isLink = (notification.object != nil)
        self.tblCustomer.reloadData()
    }
    
    func cancelBarButtonItemClicked() {
        self.searchBarCancelButtonClicked(self.txtSearchBar)
    }
    
    func filterCustomers(str: String) {
        let txt = str.lowercased()
        arrFilteredCustomers = arrCustomer.filter{ customer in
            return ((customer.firstName?.lowercased().contains(txt))! ||
                (customer.lastName?.lowercased().contains(txt))! ||
                (customer.ciry?.lowercased().contains(txt))!
            )
        }
        tblCustomer.reloadData()
    }
    
    func popRelationView() {
        transperentView = UIView(frame: UIScreen.main.bounds)
        transperentView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
        if !self.view.subviews.contains(transperentView) {
            self.view.addSubview(transperentView)
        }
        view.addSubview(self.vwRelation)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler))
        tap.cancelsTouchesInView = false
        self.transperentView.addGestureRecognizer(tap)
    }
    
    func tapHandler(){
        if self.view.subviews.contains(self.vwRelation){
            self.vwRelation.removeFromSuperview()
        }
        if self.view.subviews.contains(transperentView){
            transperentView.removeFromSuperview()
        }
    }
    
    func imageWithImage(_ image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func alertView(message: String) {
        let alert = UIAlertController(title: nil, message: "No Customer Found.", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add Customer", style: .default) { (action) in
            let customerDetailVC = NewContactVC(nibName: "NewContactVC", bundle: nil)
            self.navigationController!.pushViewController(customerDetailVC, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        self.present(alert, animated: true)
    }
    
    // MARK:- IBOutlet Method(s)
    
    
    @IBAction func handleBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleBtnMenu(_ sender: Any) {
        appDelegate.drawerController.toggleDrawerSide(.left, animated: true, completion: nil)
    }
    
    @IBAction func handleBtnNewCustomer(_ sender: Any) {
        let customerDetailVC = NewContactVC(nibName: "NewContactVC", bundle: nil)
        self.navigationController!.pushViewController(customerDetailVC, animated: true)
    }
    
    @IBAction func handleBtnAll(_ sender: Any) {
        self.btnAll.setBackgroundImage(UIImage(named: "bbox"), for: .normal)
        self.btnActive.setBackgroundImage(UIImage(named: "wbox"), for: .normal)
        self.btnInactive.setBackgroundImage(UIImage(named: "wbox"), for: .normal)
        self.btnAll.setTitleColor(UIColor.white, for: .normal)
        self.btnActive.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnInactive.setTitleColor(UIColor.lightGray, for: .normal)

    }
    
    @IBAction func handleBtnActive(_ sender: Any) {
        self.btnAll.setBackgroundImage(UIImage(named: "wbox"), for: .normal)
        self.btnActive.setBackgroundImage(UIImage(named: "bbox"), for: .normal)
        self.btnInactive.setBackgroundImage(UIImage(named: "wbox"), for: .normal)
        self.btnAll.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnActive.setTitleColor(UIColor.white, for: .normal)
        self.btnInactive.setTitleColor(UIColor.lightGray, for: .normal)

    }
    
    @IBAction func handleBtnInactive(_ sender: Any) {
        self.btnAll.setBackgroundImage(UIImage(named: "wbox"), for: .normal)
        self.btnActive.setBackgroundImage(UIImage(named: "wbox"), for: .normal)
        self.btnInactive.setBackgroundImage(UIImage(named: "bbox"), for: .normal)
        self.btnAll.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnActive.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnInactive.setTitleColor(UIColor.white, for: .normal)
    }
}
