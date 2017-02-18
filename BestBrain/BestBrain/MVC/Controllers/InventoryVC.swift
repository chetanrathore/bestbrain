//
//  InventoryVC.swift
//  BestBrain
//
//  Created by sparth on 1/30/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class InventoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var InventorySegment: UISegmentedControl!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnFilter: UIButton!
    @IBOutlet var tblInventory: UITableView!
    @IBOutlet var vwNavigationBar: UIView!
    @IBOutlet var vwSegment: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        tblInventory.tableFooterView = UIView()
        tblInventory.dataSource = self
        tblInventory.register(UINib(nibName: "InventoryCell", bundle: nil), forCellReuseIdentifier: "InventoryCell")
        //        let imgBackground = UIImageView(frame: tblInventory.bounds)
        //        imgBackground.image =  UIImage(named: "temp_back.jpeg")
        //        tblInventory.backgroundView = imgBackground
        tblInventory.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- tableview methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! InventoryCell
        cell.setCellInterface()
        cell.imgInventory.image = UIImage(named: "bike.jpg")
        cell.btnView.addTarget(self, action: #selector(btnView), for: .touchUpInside)
        return cell
    }
    
    func btnView(sender: UIButton) {
        let detailVC = InventoryDetailVC(nibName: "InventoryDetailVC", bundle: nil)
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    // MARK:- Navigation handler
    
    @IBAction func btnFilter(_ sender: UIButton) {
        let filterVC = InventoryFilterVC(nibName: "InventoryFilterVC", bundle: nil)
        self.navigationController!.pushViewController(filterVC, animated: true)
    }
    
    @IBAction func handleBtnBack(_ sender: Any) {
        appDelegate.setupDrawer(centerVC: self)
//        self.navigationController!.popViewController(animated: true)
    }
    
    
}
