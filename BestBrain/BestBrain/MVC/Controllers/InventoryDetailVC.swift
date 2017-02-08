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
    
    @IBOutlet var vwDetails: UIView!
    @IBOutlet var vwMenu: UIView!
    @IBOutlet var vwInfo: UIView!
    
    @IBOutlet var vwOtherInfo: UIView!
    @IBOutlet var btnAddBike: UIButton!
    
    @IBOutlet var constVWBtnHeight: NSLayoutConstraint!
    
    @IBOutlet var constVWScrollHeight: NSLayoutConstraint!
    @IBOutlet var constVWBottomHeight: NSLayoutConstraint!
    @IBOutlet var constImageHeight: NSLayoutConstraint!
    
    @IBOutlet var constBtnSpacing1: NSLayoutConstraint!
    
    @IBOutlet var constBtnSpacing2: NSLayoutConstraint!
    
    var isFromInventory: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        if !isFromInventory {
            btnAddBike.isHidden = true
            vwOtherInfo.isHidden = false
        }else {
            btnAddBike.isHidden = false
            vwOtherInfo.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        if isFromInventory {
            btnAddBike.frame = CGRect(x: self.btnQuote.frame.origin.x, y: self.btnAddBike.frame.origin.y, width: 150, height: 150)
            btnAddBike.imageEdgeInsets = UIEdgeInsetsMake(25, 40, 40, 25)
            btnAddBike.titleEdgeInsets = UIEdgeInsetsMake(100, -90, 0, 0)
        }
    }
    
    func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            constVWBtnHeight.constant = 150
            constVWScrollHeight.constant = 1000
            constImageHeight.constant = 400
            //  constVWBottomHeight.constant = 600
            let fontName = (self.btnMMSInfo.titleLabel?.font.fontName)!
            btnMMSInfo.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnMMSInfo.titleEdgeInsets = UIEdgeInsetsMake(100, -70, 0, 0)
            
            btnMMSInfo.imageEdgeInsets = UIEdgeInsetsMake(15, 35, 30, 20)
            //top left bottom right
            btnEmailInfo.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnEmailInfo.titleEdgeInsets = UIEdgeInsetsMake(100, -70, 0, 0)
            btnEmailInfo.imageEdgeInsets = UIEdgeInsetsMake(15, 35, 30, 20)
            
            btnQuote.titleLabel?.font = UIFont(name: fontName, size: 18)
            btnQuote.titleEdgeInsets = UIEdgeInsetsMake(100, -70, 0, 0)
            btnQuote.imageEdgeInsets = UIEdgeInsetsMake(15, 35, 30, 20)
            constBtnSpacing1.constant = 50
            constBtnSpacing2.constant = 50
            
        }else{
            constVWBtnHeight.constant = 80
            constVWScrollHeight.constant = 650
            constImageHeight.constant = 250
            //      constVWBottomHeight.constant = 400
            
            constBtnSpacing1.constant = 20
            constBtnSpacing2.constant = 20
        }
        
        vwDetails.gradientLayer()
        vwDetails.bringSubview(toFront: vwMenu)
        vwDetails.bringSubview(toFront: vwInfo)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handelTapGuesture(_:)))
        imgInventory.isUserInteractionEnabled = true
        imgInventory.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func btnNavBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    func handelTapGuesture(_ sender: UITapGestureRecognizer) {
        let detailVC = InventoryDetailWithMenuVC(nibName: "InventoryDetailWithMenuVC", bundle: nil)
        detailVC.isFromInventoryVC = true
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func btnMMSInfo(_ sender: UIButton) {
    }
    
    @IBAction func btnEmailInfo(_ sender: UIButton) {
    }
    
    @IBAction func btnQuote(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnAddBike(_ sender: UIButton) {
    }
    
    
}
