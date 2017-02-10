//
//  DLScanCameraVC.swift
//  BestBrain
//
//  Created by anuradha on 2/6/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit
import MicroBlink

class DLScanCameraVC: UIViewController, PPScanningDelegate {

    let cameraVC:UIViewController! = nil
    var response:String = ""
    var isFromDLScan:Bool = true
    var isFromVINScan:Bool = false
    @IBOutlet var vwCamera: UIView!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnFlash: UIButton!
    @IBOutlet var btnPicture: UIButton!
    @IBOutlet var btnBarcode: UIButton!
    
    @IBOutlet var vwBottom: UIView!
    @IBOutlet var vwDL: UIView!
    @IBOutlet var vwVIN: UIView!
    @IBOutlet var lbOff: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo){
            if (device.hasTorch) {
                do {
                    //try device.lockForConfiguration()
                    if (device.torchMode == AVCaptureTorchMode.on) {
                      //  device.torchMode = AVCaptureTorchMode.off
                        lbOff.text = "On"
                    } else {
                        lbOff.text = "Off"
                    }
                  //  device.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }

        setBottomView()
        starScanning()
    }
    func setBottomView(){
        for vw in vwBottom.subviews{
            vw.removeFromSuperview()
        }
        if isFromDLScan{
            vwBottom.addSubview(vwDL)
        }else if isFromVINScan{
            vwBottom.addSubview(vwVIN)
        }

    }
    func starScanning()
    {
        let error : NSErrorPointer = nil
        guard let coordinator : PPCameraCoordinator = self.getCoordinatorWithError(error: error)
            else
        {
            let messageString: String = (error!.pointee?.localizedDescription)!
            UIAlertView(title: "Warning", message: messageString, delegate: nil, cancelButtonTitle: "Ok").show()
            return
        }
        
        let cameraVC : UIViewController =
            coordinator.cameraViewController(with: self)
        cameraVC.view.frame = vwCamera.frame
        if vwCamera.subviews.contains(cameraVC.view){
            cameraVC.removeFromParentViewController()
            cameraVC.view.removeFromSuperview()
        }
        vwCamera.addSubview(cameraVC.view)
        self.addChildViewController(cameraVC)
    }

    private func getCoordinatorWithError(error: NSErrorPointer) -> PPCameraCoordinator?
    {
        if PPCameraCoordinator.isScanningUnsupported(for: PPCameraType.back, error:error) {
            return nil
        }
        let settings: PPSettings = PPSettings()
        // Visit www.microblink.com to get the license key for your app
        settings.licenseSettings.licenseKey = "XYF6FHRT-MSNEPRPI-S4E5KI4O-RF33F4BD-R2EXPMXQ-EOHIS55S-6ARY5CLX-WLYHEMHJ"
        
        do {
            // To initialize the PDF417 recognizer settings
            let ocrRecognizerSettings: PPPdf417RecognizerSettings = PPPdf417RecognizerSettings()
            settings.scanSettings.add(ocrRecognizerSettings)
        }
        // To scan US drivers licenses
        do {
            let usdlRecognizerSettings: PPUsdlRecognizerSettings = PPUsdlRecognizerSettings()
            settings.scanSettings.add(usdlRecognizerSettings)
        }
        // To scan Barcode(VIN 128-Code)
        do {
            let barRecognizerSettings: PPBarDecoderRecognizerSettings = PPBarDecoderRecognizerSettings()
            barRecognizerSettings.scanCode128 = true
            barRecognizerSettings.scanCode39 = true
            settings.scanSettings.add(barRecognizerSettings)
        }
        let coordinator: PPCameraCoordinator = PPCameraCoordinator(settings: settings)
        return coordinator
    }
    
    func getAddressValue(message:String)
    {
        //  let myAddress = Address()
        //  let valueDict : NSMutableDictionary = myAddress.getMyAddress(response)
        //  print(valueDict)
        // print("success")
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK:- PPScanningDelegate Methods
    func scanningViewController(_ scanningViewController: UIViewController?, didOutputResults results: [PPRecognizerResult]) {
        
        let scanConroller: PPScanningViewController = scanningViewController as! PPScanningViewController
        if (results.count == 0) {
            return
        }
        scanConroller.pauseScanning()
        
        var message: String = ""
        var title: String = ""
        var usdlFound = false;
        var isRequiredScannar = false //Check,required type for scan?
        
        let vc = NewContactVC(nibName: "NewContactVC", bundle: nil)
        if isFromDLScan{
            for result in results {
                if(result is PPUsdlRecognizerResult) {
                    /** US drivers license was detected */
                    let usdlResult = result as! PPUsdlRecognizerResult
                    title = "USDL"
                    //message = usdlResult.getAllStringElements().description
                    let userDetails = usdlResult.getAllStringElements() as NSDictionary
                    
                    
                    vc.firstName = userDetails.value(forKey: "Customer First Name") as! String
                    vc.lastName = userDetails.value(forKey: "Customer Family Name") as! String
                    vc.address = userDetails.value(forKey: "Address - Street 1") as! String
                    vc.city = userDetails.value(forKey: "Address - City") as! String
                    vc.state = userDetails.value(forKey: "Address - Jurisdiction Code") as! String
                    vc.zipcode = userDetails.value(forKey: "Address - Postal Code") as! String
                    vc.birthdate = userDetails.value(forKey: "Date of Birth") as! String
                    vc.dlnum = userDetails.value(forKey: "Customer First Name") as! String
                    vc.dlState = userDetails.value(forKey: "Customer First Name") as! String
                    
                    vc.isFromScanning = true
                    
                    //usdlFound = true
                    isRequiredScannar = true
                    
                    break
                }else{
                    print("DL Scanning is wrong")
                }
            }

        }else if isFromVINScan{
            for result in results {
                if(result is PPPdf417RecognizerResult) {
                    let pdf417Result = result as! PPPdf417RecognizerResult
                    title = "PDF417"
                    message = pdf417Result.stringUsingGuessedEncoding()
                    isRequiredScannar = true
                }
                else if(result is PPBarDecoderRecognizerResult) {
                    let barDecoderResult = result as! PPBarDecoderRecognizerResult
                    title = "BarDecoder VIN Code-128"
                    message = barDecoderResult.stringUsingGuessedEncoding()
                    isRequiredScannar = true
                }else{
                    print("VIN Scanning is wrong")
                }
            }
        }
        // Collect US drivers license
        // Collect other results
 //       if (!usdlFound) {
//        }
        
        if(!isRequiredScannar){
            response = ""
            return
        }else{
            response = message
            DispatchQueue.main.async(execute: {
                self.dismiss(animated: true, completion: nil)
            })
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scanningViewControllerUnauthorizedCamera(_ scanningViewController: UIViewController) {
        UIAlertView(title: "Warning", message: "user doesn't allow usage of the phone's camera", delegate: nil, cancelButtonTitle: "Ok").show()
        // Add any logic which handles UI when app user doesn't allow usage of the phone's camera
    }
    
    func scanningViewController(scanningViewController: UIViewController, didFindError error: NSError) {
        UIAlertView(title: "Warning", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "Ok").show()
        // Can be ignored. See description of the method
    }
    
    func scanningViewControllerDidClose(_ scanningViewController: UIViewController) {
        // As scanning view controller is presented full screen and modally, dismiss it
        self.dismiss(animated: true, completion: nil)
    }
    
    public func scanningViewController(_ scanningViewController: UIViewController, didFindError error: Error) {
        UIAlertView(title: "Warning", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "Ok").show()
    }

    @IBAction func handleBtnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleBtnFlash(_ sender: Any) {
        toggleFlash()
    }
    @IBAction func handleBtnPicture(_ sender: Any) {
    }
    @IBAction func handleBtnBarcode(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleFlash() {
        if let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo){
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.on) {
                    device.torchMode = AVCaptureTorchMode.off
                    lbOff.text = "Off"
                } else {
                    lbOff.text = "On"
                    do {
                        try device.setTorchModeOnWithLevel(1.0)
                    } catch {
                        print(error)
                    }
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
