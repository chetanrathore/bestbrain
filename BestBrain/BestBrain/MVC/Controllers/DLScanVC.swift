//
//  DLScanVC.swift
//  BestBrain
//
//  Created by anuradha on 2/2/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit
import MicroBlink

class DLScanVC: UIViewController, PPScanningDelegate {

    var response:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func scanClicked(_ sender: Any) {
            self.starScanning()
    }
    private func getCoordinatorWithError(error: NSErrorPointer) -> PPCameraCoordinator?
    {
        if PPCameraCoordinator.isScanningUnsupported(for: PPCameraType.back, error:error) {
            return nil
        }
        let settings: PPSettings = PPSettings()
        // Visit www.microblink.com to get the license key for your app
        settings.licenseSettings.licenseKey = "6YWMZA6Z-4WVGMDWQ-TNIES7YR-BCFG2KPC-YGW4WVFY-IFKLQQKU-XBAVJOCB-KS4BBVRT"
        
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
        let scanningViewController: UIViewController = PPViewControllerFactory.cameraViewController(with: self, coordinator: coordinator, error: nil)
        self.present(scanningViewController, animated: true, completion: nil)
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
        // Collect US drivers license
        for result in results {
            if(result is PPUsdlRecognizerResult) {
                /** US drivers license was detected */
                let usdlResult = result as! PPUsdlRecognizerResult
                title = "USDL"
                message = usdlResult.getAllStringElements().description
                usdlFound = true
                isRequiredScannar = true
                break
            }
        }
        // Collect other results
        if (!usdlFound) {
            for result in results {
                if(result is PPPdf417RecognizerResult) {
                    let pdf417Result = result as! PPPdf417RecognizerResult
                    title = "PDF417"
                    message = pdf417Result.stringUsingGuessedEncoding()
                    isRequiredScannar = true
                }
                if(result is PPBarDecoderRecognizerResult) {
                    let barDecoderResult = result as! PPBarDecoderRecognizerResult
                    title = "BarDecoder VIN Code-128"
                    message = barDecoderResult.stringUsingGuessedEncoding()
                    isRequiredScannar = true
                }
            }
        }
        if(!isRequiredScannar){
            response = ""
            return
        }else{
            response = message
            let alertController: UIAlertController = UIAlertController.init(title: title, message: response, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default,
                                                             handler: { (action) -> Void in
                                                                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAction)
            scanningViewController?.present(alertController, animated: true, completion: nil)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
