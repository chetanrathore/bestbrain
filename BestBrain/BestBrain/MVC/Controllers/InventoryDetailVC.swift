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
    
    @IBOutlet var btnMMSInfo: UIButton!
    
    @IBOutlet var btnEmailInfo: UIButton!
    
    @IBOutlet var btnQuote: UIButton!
    
    @IBOutlet var constVWBtnHeight: NSLayoutConstraint!
    
    @IBOutlet var constVWScrollHeight: NSLayoutConstraint!
    @IBOutlet var constVWBottomHeight: NSLayoutConstraint!
    @IBOutlet var constImageHeight: NSLayoutConstraint!
    
    @IBOutlet var constBtnSpacing1: NSLayoutConstraint!
    
    @IBOutlet var constBtnSpacing2: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            constVWBtnHeight.constant = 150
            constVWScrollHeight.constant = 1000
            constImageHeight.constant = 400
            constVWBottomHeight.constant = 600
            let fontName = (self.btnMMSInfo.titleLabel?.font.fontName)!
            btnMMSInfo.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnMMSInfo.titleEdgeInsets = UIEdgeInsetsMake(100, -120, 0, 0)
            
            btnEmailInfo.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnEmailInfo.titleEdgeInsets = UIEdgeInsetsMake(100, -120, 0, 0)
            
            btnQuote.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnQuote.titleEdgeInsets = UIEdgeInsetsMake(100, -120, 0, 0)
           
            constBtnSpacing1.constant = 50
            constBtnSpacing2.constant = 50
         }else{
            constVWBtnHeight.constant = 85
            constVWScrollHeight.constant = 650
            constImageHeight.constant = 250
            constVWBottomHeight.constant = 400
            
            constBtnSpacing1.constant = 20
            constBtnSpacing2.constant = 20
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handelTapGuesture(_:)))
        imgInventory.isUserInteractionEnabled = true
        imgInventory.addGestureRecognizer(tapGesture)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNavBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    func handelTapGuesture(_ sender: UITapGestureRecognizer) {
        let detailVC = InventoryDetailWithMenuVC(nibName: "InventoryDetailWithMenuVC", bundle: nil)
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func btnMMSInfo(_ sender: UIButton) {
    }
    
    @IBAction func btnEmailInfo(_ sender: UIButton) {
    }
    
    @IBAction func btnQuote(_ sender: UIButton) {
    }
    
    
}
