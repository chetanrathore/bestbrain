//
//  CustomerDetailsVC.swift
//  BestBrain
//
//  Created by chetanRathore on 2/14/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class CustomerDetailsVC: UIViewController {

    @IBOutlet var lbRelateWith: UILabel!
    @IBOutlet var lbCustomerRelation: UILabel!
    @IBOutlet var lbDLNum: UILabel!
    @IBOutlet var lbDLState: UILabel!
    @IBOutlet var lbDOB: UILabel!
    @IBOutlet var lbZipcode: UILabel!
    @IBOutlet var lbState: UILabel!
    @IBOutlet var lbCity: UILabel!
    @IBOutlet var lbAddress: UILabel!
    @IBOutlet var lbLast: UILabel!
    @IBOutlet var lbFirst: UILabel!
    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var tblCustomerDetail: UITableView!
    @IBOutlet var btnback: UIButton!
    
  
    var details = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(details)
        lbFirst.text = details.value(forKey: "first") as! String?
        lbLast.text = details.value(forKey: "last") as! String?
        lbAddress.text = details.value(forKey: "address") as! String?
        lbCity.text = details.value(forKey: "city") as! String?
        lbState.text = details.value(forKey: "state") as! String?
        lbZipcode.text = details.value(forKey: "zipcode") as! String?
        lbDOB.text = details.value(forKey: "dob") as! String?
        lbDLState.text = details.value(forKey: "DLState") as! String?
        lbDLNum.text = details.value(forKey: "DLNum") as! String?
        self.tblCustomerDetail.tableFooterView = UIView()
    }
    @IBAction func handleBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLayoutSubviews() {
        imgUser.layer.cornerRadius = imgUser.frame.size.width/2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
