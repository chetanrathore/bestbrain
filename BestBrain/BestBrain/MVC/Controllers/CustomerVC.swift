//
//  CustomerVC.swift
//  BestBrain
//
//  Created by LaNet on 2/7/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class CustomerVC: UIViewController,  UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var txtSearchBar: UISearchBar!
    @IBOutlet var tblCustomer: UITableView!
    
    @IBOutlet var vwBackground: UIView!
    
    var arrCustomer = [Customer]()
    var arrFilteredCustomers = [Customer]()
    
    var isSearch: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        tblCustomer.tableFooterView = UIView()
        tblCustomer.dataSource = self
        txtSearchBar.delegate = self
        tblCustomer.delegate = self
        tblCustomer.register(UINib(nibName: "CustomerCell", bundle: nil), forCellReuseIdentifier: "CustomerCell")
        //        let imgBackground = UIImageView(frame: tblCustomer.bounds)
        //        imgBackground.image =  UIImage(named: "temp_back.jpeg")
        //        tblCustomer.backgroundView = imgBackground
        
        //Temporary data
        let customer1 = Customer(firstName: "John", lastName: "other details", city: "New York")
        let customer2 = Customer(firstName: "tmp", lastName: "xcvxcv", city: "New York")
        let customer3 = Customer(firstName: "John Khan", lastName: "Xyvxcvz", city: "New York")
        let customer4 = Customer(firstName: "John", lastName: "Xy45646z", city: "New York")
        let customer5 = Customer(firstName: "John", lastName: "Xy6565z", city: "New York")
        let customer6 = Customer(firstName: "Abcd", lastName: "Xytyty56fgz", city: "New York")
        
        arrCustomer.append(customer1)
        arrCustomer.append(customer2)
        arrCustomer.append(customer3)
        arrCustomer.append(customer4)
        arrCustomer.append(customer5)
        arrCustomer.append(customer6)
        
        self.vwBackground.gradientLayer()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            if arrFilteredCustomers.count == 0 {
                vwBackground.isHidden = true
                alertView(message: "No Such Customer Found.")
            }else {
                vwBackground.isHidden = false
            }
            return arrFilteredCustomers.count
        }else {
            if arrCustomer.count == 0 {
                vwBackground.isHidden = true
                alertView(message: "No Customer Found.")
            }else {
                vwBackground.isHidden = false
            }
            return arrCustomer.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var customer = Customer()
        if isSearch {
            customer = self.arrFilteredCustomers[indexPath.row]
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
        let customerDetailVC = NewContactVC(nibName: "NewContactVC", bundle: nil)
        self.navigationController!.pushViewController(customerDetailVC, animated: true)
    }
    
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
    
    @IBAction func handleBtnBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
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
    
}
