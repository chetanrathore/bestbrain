//
//  SpeedoMeterVC.swift
//  BestBrain
//
//  Created by Suhani on 02/02/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit
import EPSignature

class SpeedoMeterVC: UIViewController {
  
    
    @IBOutlet var imgDownPayDial: UIImageView!
    @IBOutlet var imgDownPayPin: UIImageView!
    @IBOutlet var imgDownPayDot: UIImageView!
    @IBOutlet var lblDownPay: UILabel!
    
    @IBOutlet var imgTermDial: UIImageView!
    @IBOutlet var imgTermPin: UIImageView!
    @IBOutlet var imgTermDot: UIImageView!
    @IBOutlet var lblTerm: UILabel!
    
    @IBOutlet var imgMonthlyPayDial: UIImageView!
    @IBOutlet var imgMonthlyPayPin: UIImageView!
    @IBOutlet var imgMonthlyPayDot: UIImageView!
    @IBOutlet var lblMonthlyPay: UILabel!
    
    @IBOutlet var sliderDownPay: UISlider!
    @IBOutlet var sliderTerm: UISlider!
    @IBOutlet var sliderMonthlyPay: UISlider!
    
    @IBOutlet var vwDisclaimer: UIView!
    @IBOutlet var lblDecleration: UILabel!
    @IBOutlet var imgSignature: UIImageView!
    @IBOutlet var signatureView: EPSignatureView!
    
    var speedometerCurrentValue, prevAngleFactor, angle: Float!
    var maxVal: String!
    var isDPayment, isAPayment, isTerm: Bool!
    var transperentView = UIView()
    var point = CGPoint.zero
    var mouseSwiped: Bool = false
    var mouseMoved: Int = 0
    var declarationText = "Monthly payments are based on average model family pricing and are only estimates based on average credit situations. Credit terms are subject to approval from Harley Davidson Financial Service or secondary financing sources. These are strictly estimates and may differ on exact model selected, factory options, additional parts and accessories or any other additional products beyond the vehicle selected."
    open weak var signatureDelegate: EPSignatureDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mouseMoved = 0
        
        self.setUpView()
        // Set Previous Angle
        self.popDisclaimerView()
        self.prevAngleFactor = -135.4;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.vwDisclaimer.layer.cornerRadius = 7.0
    }
    
    func popDisclaimerView(){
        self.lblDecleration.text = self.declarationText
        self.lblDecleration.frame.size.height = heightForView(text: self.declarationText, font: UIFont.boldSystemFont(ofSize: 17.0), width: self.lblDecleration.frame.size.width)
        self.lblDecleration.sizeToFit()
        self.vwDisclaimer.frame = CGRect(x: self.view.center.x - self.lblDecleration.frame.size.width/2, y: self.view.center.y - self.lblDecleration.frame.size.height, width: ScreenWidth - 40, height: self.signatureView.frame.origin.y + self.signatureView.frame.height + 20)
        transperentView = UIView(frame: UIScreen.main.bounds)
        transperentView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
        if !self.view.subviews.contains(transperentView) {
            self.view.addSubview(transperentView)
        }
        view.addSubview(self.vwDisclaimer)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler))
        tap.cancelsTouchesInView = false
        self.transperentView.addGestureRecognizer(tap)
    }
    
    func tapHandler(){
        if self.view.subviews.contains(self.vwDisclaimer){
            self.vwDisclaimer.removeFromSuperview()
        }
        if self.view.subviews.contains(transperentView){
            transperentView.removeFromSuperview()
        }
    }
    
    func setUpView() {
        // Down Payment Dial
        self.imgDownPayPin.frame = CGRect(x: self.imgDownPayDial.center.x - self.imgDownPayPin.frame.size.width/2, y: self.imgDownPayDial.center.y - self.imgDownPayPin.frame.size.height/2 , width: self.imgDownPayPin.frame.size.width + 3, height: self.imgDownPayDial.frame.size.height/2)
        self.imgDownPayDot.frame = CGRect(x: self.imgDownPayDial.center.x - self.imgDownPayDot.frame.size.width/2, y: self.imgDownPayDial.center.y - self.imgDownPayDot.frame.size.height/2, width: self.imgDownPayDot.frame.size.width, height: self.imgDownPayDot.frame.size.height)
        self.imgDownPayPin.layer.anchorPoint = CGPoint(x: self.imgDownPayPin.layer.anchorPoint.x, y: self.imgDownPayPin.layer.anchorPoint.y*2)
        
        // Monthly Payment Dial
        
        self.imgMonthlyPayPin.frame = CGRect(x: self.imgMonthlyPayDial.center.x - self.imgMonthlyPayPin.frame.size.width/2, y: self.imgMonthlyPayDial.center.y - self.imgMonthlyPayPin.frame.size.height/2 , width: self.imgMonthlyPayPin.frame.size.width + 3, height: self.imgMonthlyPayDial.frame.size.height/2)
        self.imgMonthlyPayDot.frame = CGRect(x: self.imgMonthlyPayDial.center.x - self.imgMonthlyPayDot.frame.size.width/2, y: self.imgMonthlyPayDial.center.y - self.imgMonthlyPayDot.frame.size.height/2, width: self.imgMonthlyPayDot.frame.size.width, height: self.imgMonthlyPayDot.frame.size.height)
        self.imgMonthlyPayPin.layer.anchorPoint = CGPoint(x: self.imgMonthlyPayPin.layer.anchorPoint.x, y: self.imgMonthlyPayPin.layer.anchorPoint.y*2)
        
        // Terms Dial
        
        self.imgTermPin.frame = CGRect(x: self.imgTermDial.center.x - self.imgTermPin.frame.size.width/2, y: self.imgTermDial.center.y - self.imgTermPin.frame.size.height/2 , width: self.imgTermPin.frame.size.width + 2, height: self.imgTermDial.frame.size.height/2)
        self.imgTermDot.frame = CGRect(x: self.imgTermDial.center.x - self.imgTermDot.frame.size.width/2, y: self.imgTermDial.center.y - self.imgTermDot.frame.size.height/2, width: self.imgTermDot.frame.size.width, height: self.imgTermDot.frame.size.height)
        self.imgTermPin.layer.anchorPoint = CGPoint(x: self.imgTermPin.layer.anchorPoint.x, y: self.imgTermPin.layer.anchorPoint.y*2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- calculateDeviationAngle Method
    
    func calculateDeviationAngle() {
        if self.isDPayment! {
            self.maxVal = "1000"
        } else if self.isAPayment! {
            self.maxVal = "10000"
        } else {
            self.maxVal = "110"
        }
        
        if Float(self.maxVal)! > 0 {
            self.angle = (self.speedometerCurrentValue * 271.4)/(Float(self.maxVal))!-135.4
        } else {
            self.angle = 0
        }
        
        if self.angle <= -135.4 {
            self.angle = -135.4
        }
        
        if self.angle >= 136 {
            self.angle = 136
        }
        
        // If Calculated angle is greater than 180 deg, to avoid the needle to rotate in reverse direction first rotate the needle 1/3 of the calculated angle and then 2/3. //
        
        if abs(self.angle - self.prevAngleFactor) > 180 {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            self.rorateIt(angl: self.angle/3)
            UIView.commitAnimations()
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            self.rorateIt(angl: self.angle*2/3)
            UIView.commitAnimations()
        }
        
        self.prevAngleFactor = self.angle
        // Rotate Needle
        self.rotateNeedle()
    }
    
    // MARK:- rotateNeedle Method

    func rotateNeedle() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        let rotationAngle = (.pi/180)*self.angle
        if self.isDPayment! {
            self.imgDownPayPin.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        } else if self.isAPayment! {
            self.imgMonthlyPayPin.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        } else {
            self.imgTermPin.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        }
        UIView.commitAnimations()
    }
    
    // MARK:- Speedometer needle Rotation View Methods
    
    func rorateIt(angl: Float) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.01)
        let rotationAngle = (.pi/180)*angl
        if self.isDPayment! {
            self.imgDownPayPin.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        } else if self.isAPayment! {
            self.imgMonthlyPayPin.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        } else {
            self.imgTermPin.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        }
        UIView.commitAnimations()
    }
    
    // MARK:- Slider Action Methods
    
   
    @IBAction func handleSliderDownPay(_ sender: Any) {
        self.isDPayment = true
        self.isAPayment = false
        self.isTerm = false
        
        self.speedometerCurrentValue = self.sliderDownPay.value * 1000;
        self.lblDownPay.text = self.speedometerCurrentValue.description
        self.calculateDeviationAngle()
    }
    
    @IBAction func handleSliderMonthlyPay(_ sender: Any) {
        self.isDPayment = false
        self.isAPayment = true
        self.isTerm = false
        
        self.speedometerCurrentValue = self.sliderMonthlyPay.value * 1000;
        self.lblMonthlyPay.text = self.speedometerCurrentValue.description
        self.calculateDeviationAngle()
    }
    
    @IBAction func handleSliderTerms(_ sender: Any) {
        self.isDPayment = false
        self.isAPayment = false
        self.isTerm = true
        
        self.speedometerCurrentValue = self.sliderTerm.value * 1000;
        self.lblTerm.text = self.speedometerCurrentValue.description
        self.calculateDeviationAngle()
    }

    func epSignature(_: EPSignatureViewController, didSign signatureImage: UIImage, boundingRect: CGRect) {
        print(signatureImage)
        self.imgSignature.image = signatureImage
    }
   
    // MARK:- calculate Interest
    
}
