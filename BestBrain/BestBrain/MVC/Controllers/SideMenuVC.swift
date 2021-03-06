//
//  SideMenuVC.swift
//  BestBrain
//
//  Created by Suhani on 17/02/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tblDashboardMenu: UITableView!
    @IBOutlet var btnProfile: UIButton!

    var arrTblMenuItem = ["setting","DLScan","deskLog","inventory","customer","chat","quotes","Logout"]
    var arrTblMenuLbl = ["Dashboard","DLScan", "Desk Log", "Inventory", "Customer", "Chat", "Quotes","Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblDashboardMenu.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "sideMenuCell")
        self.tblDashboardMenu.dataSource = self
        self.tblDashboardMenu.delegate = self
        self.tblDashboardMenu.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        self.evo_drawerController?.navigationController?.navigationBar.isHidden = true
        
//        self.tblDashboardMenu.scrollToRow(at: IndexPath(item: arrTblMenuItem.count-1, section: 0), at: .top, animated: false)
        self.tblDashboardMenu.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- TableView Method(s)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.arrTblMenuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as! SideMenuCell
        cell.lblItem.text = self.arrTblMenuLbl[indexPath.row]
        cell.imgItem.image = UIImage(named: self.arrTblMenuItem[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
            case 0:
                let nav = UINavigationController(rootViewController: CustomerDashboardVC())
                appDelegate.drawerController.centerViewController = nav
                appDelegate.drawerController.closeDrawer(animated: true, completion: nil)
            case 1:
                let nav = UINavigationController(rootViewController: DLScanCameraVC())
                appDelegate.drawerController.centerViewController = nav
                appDelegate.drawerController.closeDrawer(animated: true, completion: nil)
            case 2:break
            case 3:
                let nav = UINavigationController(rootViewController: InventoryVC())
                appDelegate.drawerController.centerViewController = nav
                appDelegate.drawerController.closeDrawer(animated: true, completion: nil)
            case 4:
                let nav = UINavigationController(rootViewController: CustomerVC())
                appDelegate.drawerController.centerViewController = nav
                appDelegate.drawerController.closeDrawer(animated: true, completion: nil)
            case 5:break
            case 6:break
            //                appDelegate.drawerController.centerViewController = SpeedoMeterVC()
        //                appDelegate.drawerController.closeDrawer(animated: true, completion: nil)
            case 7:
                self.navigationController?.popToRootViewController(animated: true)

            default: break
        }
        
    }
    // MARK:- IBOutlet Method(s)
    
    @IBAction func handleBtnProfile(_ sender: Any) {
        let vc = ProfileVC(nibName: "ProfileVC", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        appDelegate.drawerController.centerViewController = nav
        appDelegate.drawerController.closeDrawer(animated: true, completion: nil)
    }
 
}
