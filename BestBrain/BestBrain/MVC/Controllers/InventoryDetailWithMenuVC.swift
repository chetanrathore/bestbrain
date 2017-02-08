//
//  InventoryDetailWithMenuVC.swift
//  BestBrain
//
//  Created by LaNet on 2/6/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class InventoryDetailWithMenuVC: UIViewController {
    
    @IBOutlet var scrollViewMain: UIScrollView!
    
    @IBOutlet var btnServiceHistory: UIButton!
    
    @IBOutlet var btnACV: UIButton!
    
    @IBOutlet var btnSalesHistory: UIButton!
    
    @IBOutlet var btnAddPhoto: UIButton!
    
    
    @IBOutlet var btnAddAppraisal: UIButton!
    
    @IBOutlet var vwDetails: UIView!
    
    @IBOutlet var vwInfo: UIView!
    
    @IBOutlet var vwMenuItem: UIView!
    
    @IBOutlet var constVWBtnHeight: NSLayoutConstraint!
    @IBOutlet var constVWScrollHeight: NSLayoutConstraint!
    @IBOutlet var constVWBottomHeight: NSLayoutConstraint!
    @IBOutlet var constImageHeight: NSLayoutConstraint!
    
    @IBOutlet var constBtnSpacing1: NSLayoutConstraint!
    
    @IBOutlet var constBtnSpacing2: NSLayoutConstraint!
    
    @IBOutlet var constBtnVerSpacing: NSLayoutConstraint!
    
    var isFromInventoryVC: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        
        if isFromInventoryVC {
            self.btnAddPhoto.tag = 1
            self.btnAddAppraisal.isHidden = true
        }else{
            self.btnAddAppraisal.isHidden = false
            self.btnAddPhoto.isHidden = true
            self.btnAddPhoto.tag = 2
            self.btnSalesHistory.setImage(UIImage(named: "photo-camera.png"), for: .normal)
            self.btnSalesHistory.setTitle("Add Photo", for: .normal)
        
            btnAddAppraisal.layer.cornerRadius = 2
            btnAddAppraisal.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            btnAddAppraisal.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            btnAddAppraisal.layer.shadowOpacity = 0.8
            btnAddAppraisal.layer.shadowRadius = 2.0
            btnAddAppraisal.layer.masksToBounds = false
            btnAddAppraisal.layer.cornerRadius = 2.0
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        //    scrollViewMain.contentSize = CGSize(width: ScreenWidth, height: 647)
        vwDetails.gradientLayer()
        vwDetails.bringSubview(toFront: vwInfo)
        vwDetails.bringSubview(toFront: vwMenuItem)
        btnAddPhoto.superview?.bringSubview(toFront: btnAddPhoto)
        btnAddAppraisal.superview?.bringSubview(toFront: btnAddAppraisal)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            constVWBtnHeight.constant = 120
            constVWScrollHeight.constant = 1000
            constImageHeight.constant = 400
            constVWBottomHeight.constant = 600
            let fontName = (self.btnServiceHistory.titleLabel?.font.fontName)!
            btnServiceHistory.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnServiceHistory.titleEdgeInsets = UIEdgeInsetsMake(100, -150, 0, 0)
            
            btnACV.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnACV.titleEdgeInsets = UIEdgeInsetsMake(100, -130, 0, 0)
            
            btnSalesHistory.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnSalesHistory.titleEdgeInsets = UIEdgeInsetsMake(100, -140, 0, 0)
            
            btnAddPhoto.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnAddPhoto.titleEdgeInsets = UIEdgeInsetsMake(100, -120, 0, 0)
            constBtnSpacing1.constant = 50
            constBtnSpacing2.constant = 50
            constBtnVerSpacing.constant = 20
        }else{
            constVWBtnHeight.constant = 80
            constVWScrollHeight.constant = 650
            constImageHeight.constant = 250
            constVWBottomHeight.constant = 400
        }
    }
    
    @IBAction func btnServiceHistory(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func btnACV(_ sender: UIButton) {
    }
    
    @IBAction func btnSalesHistory(_ sender: UIButton) {
        if sender.tag == 1 {
            //handle for sales history
            
        }else {
            //handle for add photo
            
        }
    }
    
    @IBAction func btnAddPhoto(_ sender: UIButton) {

    }
    
    @IBAction func handleBtnAddAppraisal(_ sender: UIButton) {
        
    }
    
    
}
