//
//  LocationManager.swift
//  BestBrain
//
//  Created by Suhani on 02/02/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var currentLocation: CLLocation!
    var locationManager: CLLocationManager!
    var stopUpdating: Bool!
    
    static let sharedInstance = LocationManager()

    override init() {
        super.init()
        self.currentLocation = CLLocation()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.stopUpdating = false
        self.start()
    }
    
    func start() {
        self.locationManager.startUpdatingLocation()
        if !(TheCurrentDeviceVersion.isLess(than: 8.0)) {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            // Check for iOS 8.     this guard the code will crash with "unknown selector" on iOS 7.
            if !(TheCurrentDeviceVersion.isLess(than: 8.0)) {
                if self.locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
                    self.locationManager.requestWhenInUseAuthorization()
                }
            }
            // Do any additional setup after loading the view, typically from a nib.
        }
        self.stopUpdating = false
    }
    
    func stop() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.stopMonitoringSignificantLocationChanges()
        self.stopUpdating = true
    }
    
    func locationKnown() -> Bool {
        //if (round(currentLocation.speed) == -1) return NO; else return YES;
        if self.currentLocation != nil {
            return true
        }
        return false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                //if the time interval returned from core location is more than two minutes we ignore it because it might be from an old session
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        if !self.stopUpdating {
            self.currentLocation = locationObj
            self.stopUpdating = true
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "LocationFound"), object: nil))
            LocationManager.sharedInstance.stop()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        print("Error in Fetching Location: \(error.localizedDescription)")
        if !self.stopUpdating {
            self.stopUpdating = true
            let userInfo: [AnyHashable: Any] = ["GPSError" : error]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationFound"), object: nil, userInfo: userInfo)
            LocationManager.sharedInstance.stop()
        }
    }
}
