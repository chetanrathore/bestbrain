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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        //    scrollViewMain.contentSize = CGSize(width: ScreenWidth, height: 647)
        vwDetails.gradientLayer()
        vwDetails.bringSubview(toFront: vwInfo)
        vwDetails.bringSubview(toFront: vwMenuItem)
        btnAddPhoto.superview?.bringSubview(toFront: btnAddPhoto)
        
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
            constVWBtnHeight.constant = 85
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
    }
    
    @IBAction func btnAddPhoto(_ sender: UIButton) {
    }
    
}
