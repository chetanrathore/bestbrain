//
//  InventoryDetailVC.swift
//  BestBrain
//
//  Created by sparth on 1/31/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class InventoryDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var cvcImageGallary: UICollectionView!
    
    @IBOutlet var pageView: UIPageControl!
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var scrollMain: UIScrollView!
    
    @IBOutlet var imgInventory: UIImageView!
    
    @IBOutlet var btnMMSInfo: UIButton!
    
    @IBOutlet var btnEmailInfo: UIButton!
    
    @IBOutlet var btnQuote: UIButton!
    
    @IBOutlet var vwDetails: UIView!
    @IBOutlet var vwMenu: UIView!
    @IBOutlet var vwInfo: UIView!
    
    @IBOutlet var vwMenu2: UIView!
    @IBOutlet var btnAddBike: UIButton!
    @IBOutlet var btnAddAnother: UIButton!
    
    @IBOutlet var btnRemove: UIButton!
    
    @IBOutlet var vwBorder: UIView!
    
    @IBOutlet var constVWScrollHeight: NSLayoutConstraint!
    
    @IBOutlet var constVWBottomHeight: NSLayoutConstraint!
    
    @IBOutlet var constImageHeight: NSLayoutConstraint!
    
    @IBOutlet var constBtnSpacing: [NSLayoutConstraint]!
    
    @IBOutlet var constMenuHeight: [NSLayoutConstraint]!
    
    var isFromInventory: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        self.cvcImageGallary.dataSource = self
        self.cvcImageGallary.delegate = self
        
        self.cvcImageGallary.register(UINib(nibName: "InventoryImageCell", bundle:nil), forCellWithReuseIdentifier: "InventoryImageCell")
        if isFromInventory {
            btnAddBike.isHidden = false
            //       vwOtherInfo.isHidden = false
        }else {
            btnAddBike.isHidden = false
            //       vwOtherInfo.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.evo_drawerController?.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        if !isFromInventory {
            if UIDevice.current.userInterfaceIdiom == .pad {
                btnAddBike.frame = CGRect(x: self.btnQuote.frame.origin.x, y: self.btnAddBike.frame.origin.y, width: 150, height: 150)
                btnAddBike.imageEdgeInsets = UIEdgeInsetsMake(25, 40, 40, 25)
                btnAddBike.titleEdgeInsets = UIEdgeInsetsMake(100, -90, 0, 0)
            }
        }
    }
    
    // MARK:- InterfaceDesign
    
    func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            //            constVWBtnHeight.constant = 150
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
            
        }else{
            //            constVWBtnHeight.constant = 85
            //            constVWScrollHeight.constant = 650
            //            constImageHeight.constant = 250
            //      constVWBottomHeight.constant = 400
        }
        if ScreenWidth > 320{
            for const in constBtnSpacing{
                const.constant = 40
            }
        }else{
            for const in constMenuHeight{
                const.constant = 80
            }
            btnAddAnother.titleEdgeInsets = UIEdgeInsets(top: 67, left: -55, bottom: 8, right: -5)
        }
        vwDetails.gradientLayer()
        vwDetails.bringSubview(toFront: vwMenu)
        vwDetails.bringSubview(toFront: vwInfo)
        vwDetails.bringSubview(toFront: vwBorder)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handelTapGuesture(_:)))
        imgInventory.isUserInteractionEnabled = true
        imgInventory.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK:- Outlet Actions
    
    @IBAction func btnNavBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func btnMMSInfo(_ sender: UIButton) {
    }
    
    @IBAction func btnEmailInfo(_ sender: UIButton) {
    }
    
    @IBAction func btnQuote(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnAddAnother(_ sender: UIButton) {
        let appraisalVC = AppraisalVC(nibName: "AppraisalVC", bundle: nil)
        self.navigationController?.pushViewController(appraisalVC, animated: true)
    }
    
    @IBAction func handleBtnRemove(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnAddBike(_ sender: UIButton) {
    }
    
    // MARK:- Collectionview method(Image gallary)
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageView.numberOfPages = 5
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InventoryImageCell", for: indexPath)  as! InventoryImageCell
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize {
        let cellSize:CGSize = CGSize(width: ScreenWidth, height: self.cvcImageGallary.frame.height)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageView.currentPage = indexPath.row
    }
    // MARK:- Custom methods
    
    func handelTapGuesture(_ sender: UITapGestureRecognizer) {
        let detailVC = InventoryDetailWithMenuVC(nibName: "InventoryDetailWithMenuVC", bundle: nil)
        detailVC.isFromInventoryVC = true
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    

    
    
}
