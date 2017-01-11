//
//  DashboardVC.swift
//  BestBrain
//
//  Created by Devloper30 on 10/01/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var topVw: UIView!
    @IBOutlet var collectionVw: UICollectionView!
    
    var arrItem = ["Quick Add", "Trade In", "Inventory", "Desired Vehicle", "Clock In"]
    var arrimage = ["b_customer", "b_trade", "b_inventory", "b_desiredvehicle", "b_clockin"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionVw.register(UINib(nibName: "DashboardCell", bundle: nil), forCellWithReuseIdentifier: "dashboardCell")
        self.collectionVw.delegate = self
        self.collectionVw.dataSource = self
        self.setUpNavigationBar()
    }
    
    func setUpNavigationBar(){
        self.navigationItem.hidesBackButton = true
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditBtn)), animated: true)
    }
    
    func handleEditBtn(){
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath) as! DashboardCell
        cell.lblItem.text = arrItem[indexPath.row]
        cell.imgItem.image = UIImage(named:arrimage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell Selected")
        if indexPath.row == 0{
            let vc = LogCustomerVC(nibName: "LogCustomerVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1{
            
        }
        if indexPath.row == 2{
            let vc = AddInventoryViewController(nibName: "AddInventoryViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 3{
            let vc = DesiredVehicleSelctionViewController(nibName: "DesiredVehicleSelctionViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 4{
            let vc = ClockInViewController(nibName: "ClockInViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let width = (ScreenWidth)/3
        return CGSize(width: width, height: width)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
