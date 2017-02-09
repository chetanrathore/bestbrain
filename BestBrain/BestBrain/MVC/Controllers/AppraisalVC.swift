//
//  AppraisalVC.swift
//  BestBrain
//
//  Created by LaNet on 2/9/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class AppraisalVC: UIViewController {
    
    @IBOutlet var scrollViewMain: UIScrollView!
    
    @IBOutlet var btnPayoff: UIButton!
    
    @IBOutlet var btnVINCheck: UIButton!
    
    @IBOutlet var btnAddPhoto: UIButton!
    
    @IBOutlet var btnRemove: UIButton!
    
    @IBOutlet var btnAddAppraisal: UIButton!
    
    @IBOutlet var btnAddAnother: UIButton!
    
    @IBOutlet var vwDetails: UIView!
    
    @IBOutlet var vwInfo: UIView!
    @IBOutlet var vwMenuItem1: UIView!
    @IBOutlet var vwMenuItem2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK:- Interface
    
    func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        vwDetails.gradientLayer()
        vwDetails.bringSubview(toFront: vwInfo)
        vwDetails.bringSubview(toFront: vwMenuItem1)
        vwDetails.bringSubview(toFront: vwMenuItem2)
    }
    
    // MARK:- Outlet Actions
    
    @IBAction func handleBtnNavBack(_ sender: UIButton) {
        
    }
    
    @IBAction func handleBtnVINCheck(_ sender: UIButton) {
        
    }
    
    @IBAction func handleBtnPayoff(_ sender: UIButton) {
        
    }
    
    @IBAction func handleBtnAddPhotos(_ sender: UIButton) {
        
    }
  
    @IBAction func handleBtnAddAnother(_ sender: UIButton) {
        
    }
    
    @IBAction func handleBtnRemove(_ sender: UIButton) {
        
    }
    
    @IBAction func handleBtnAddAppraisal(_ sender: UIButton) {
        
    }
    
}
