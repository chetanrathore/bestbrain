//
//  InventoryFilterVC.swift
//  BestBrain
//
//  Created by sparth on 1/30/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class InventoryFilterVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var yearSegment: UISegmentedControl!
    
    @IBOutlet var scrollMain: UIScrollView!
    
    @IBOutlet var pickerModel: UIPickerView!
    
    @IBOutlet var vwPayment: UIView!
    @IBOutlet var lblMinPayment: UILabel!
    @IBOutlet var lblMaxPayment: UILabel!
    @IBOutlet var swPaymentRange: UISlider!
    
    @IBOutlet var vwBottom: UIView!
    @IBOutlet var vwBackground: UIView!
    @IBOutlet var vwPrice: UIView!
    @IBOutlet var swPriceRange: UISlider!
    @IBOutlet var lblMaxPrice: UILabel!
    @IBOutlet var lblMinPrice: UILabel!
    
    @IBOutlet var btnFilter: UIButton!
    @IBOutlet var btnReset: UIButton!
    
    @IBOutlet var NLCHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        scrollMain.contentSize = CGSize(width: ScreenWidth, height: 553)
        pickerModel.dataSource = self
        pickerModel.delegate = self
        
        if UIScreen.main.bounds.size.height > 667 {
            NLCHeight.constant = 600
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLayoutSubviews() {
         setInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Interface 

    func setInterface() {
        let sliderLine1 = UIView(frame: swPaymentRange.frame)
                sliderLine1.layer.backgroundColor = UIColor.clear.cgColor
        sliderLine1.autoresizingMask = UIViewAutoresizing.flexibleWidth
        vwPayment.addSubview(sliderLine1)
        let imgLine = UIImageView()
        imgLine.frame = CGRect(x: 0, y: sliderLine1.frame.height/2-2, width: sliderLine1.frame.width, height: 5)
        imgLine.autoresizingMask = UIViewAutoresizing.flexibleWidth
        imgLine.image = UIImage(named: "line.png")
        
        sliderLine1.addSubview(imgLine)
        vwPayment.bringSubview(toFront: swPaymentRange)
        let sliderLine2 = UIView(frame: swPriceRange.frame)
        sliderLine2.layer.backgroundColor = UIColor.clear.cgColor
        sliderLine2.autoresizingMask = UIViewAutoresizing.flexibleWidth
        
        vwPrice.addSubview(sliderLine2)
         let imgLine2 = UIImageView()
        imgLine2.frame = CGRect(x: 0, y: sliderLine2.frame.height/2-2, width: sliderLine2.frame.width, height: 5)
        imgLine2.autoresizingMask = UIViewAutoresizing.flexibleWidth
        imgLine2.image = UIImage(named: "line.png")
        sliderLine2.addSubview(imgLine2)
        vwPrice.bringSubview(toFront: swPriceRange)
        vwBackground.gradientLayer()
        
    }
    
    // MARK:- Picker view methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Test data"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    //Here set the price and payment
    @IBAction func paymentValueChange(_ sender: Any) {
        let payment = (sender as! UISlider).value
        print(payment)
    }
    
    @IBAction func priceValueChange(_ sender: Any) {
        let price = (sender as! UISlider).value
        print(price)
    }
    
    // MARK:- Outlet Actions
    
    @IBAction func btnNavBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
        
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        
    }
    
    @IBAction func btnScan(_ sender: UIButton) {
        let vc = DLScanCameraVC(nibName: "DLScanCameraVC", bundle: nil)
        vc.isFromDLScan = false
        vc.isFromVINScan = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
