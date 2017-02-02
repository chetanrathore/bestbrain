//
//  InventoryDetailVC.swift
//  BestBrain
//
//  Created by sparth on 1/31/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class InventoryDetailVC: UIViewController {
    
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var scrollMain: UIScrollView!
    
    @IBOutlet var imgInventory: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        scrollMain.contentSize = CGSize(width: ScreenWidth, height: 603)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNavBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    
    @IBAction func btnMMSInfo(_ sender: UIButton) {
    }
    
    @IBAction func btnEmailInfo(_ sender: UIButton) {
    }
    
    @IBAction func btnQuote(_ sender: UIButton) {
    }
    
    
}
