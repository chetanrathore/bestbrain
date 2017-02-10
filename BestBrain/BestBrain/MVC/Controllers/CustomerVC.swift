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
    @IBOutlet var segment: UISegmentedControl!
    
    var arrCustomer = [Customer]()
    var arrFilteredCustomers = [Customer]()
    var isSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tblCustomer.tableFooterView = UIView()
        tblCustomer.dataSource = self
        txtSearchBar.delegate = self
        tblCustomer.delegate = self
        tblCustomer.register(UINib(nibName: "CustomerCell", bundle: nil), forCellReuseIdentifier: "CustomerCell")
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

        self.segment.removeBorders()
        self.segment.setBackgroundImage(UIImage(named: "wbox"), for: .normal, barMetrics: .default)
        
        //        self.segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        self.segment.setBackgroundImage(UIImage(named: "bbox"), for: .selected, barMetrics: .default)
        
        if !(txtSearchBar.text?.isEmpty)! {
            isSearch = true
            tblCustomer.reloadData()
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
    
    // MARK:- TableView Method(s)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            if arrFilteredCustomers.count == 0 {
                //                vwBackground.isHidden = true
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        cell.imgCustomer.image = UIImage(named: "user.png")
        cell.setCellInterface()
        // cell.lblCustomerName.text = customer.firstName
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    // MARK:- Segment Control Method
    
    
    // MARK:- Search Bar Delegate(s)
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
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
    }
    
    // MARK:- Custom Method(s)
    
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
    
    @IBAction func handleBtnNewCustomer(_ sender: Any) {
        let customerDetailVC = NewContactVC(nibName: "NewContactVC", bundle: nil)
        self.navigationController!.pushViewController(customerDetailVC, animated: true)
    }
    
    
}
