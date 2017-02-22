//
//  AppraisalVC.swift
//  BestBrain
//
//  Created by sparth on 2/9/17.
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
    
    @IBOutlet var constBtnSpacing: [NSLayoutConstraint]!
    
    @IBOutlet var constMenuHeight: [NSLayoutConstraint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setInterface()
    }
    
    // MARK:- Interface
    
    func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        self.evo_drawerController?.navigationController?.navigationBar.isHidden = true
        if ScreenWidth > 320{
            for const in constBtnSpacing{
                const.constant = 40
            }
        }else{
            for const in constMenuHeight{
                const.constant = 75
            }
            btnAddAnother.titleEdgeInsets = UIEdgeInsets(top: 67, left: -55, bottom: 8, right: -5)
            btnAddAppraisal.titleEdgeInsets = UIEdgeInsets(top: 67, left: -66, bottom: 8, right: -16)
        }
        vwDetails.gradientLayer()
        vwDetails.bringSubview(toFront: vwInfo)
        vwDetails.bringSubview(toFront: vwMenuItem1)
        vwDetails.bringSubview(toFront: vwMenuItem2)
    }
    
    // MARK:- Outlet Actions
    
    @IBAction func handleBtnNavBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
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
