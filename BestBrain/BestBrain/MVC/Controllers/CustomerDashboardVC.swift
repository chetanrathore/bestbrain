//
//  CustomerDashboardVC.swift
//  BestBrain
//
//  Created by Devloper30 on 30/01/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit
import CoreLocation

class CustomerDashboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, SettingsTableviewDelagate, CLLocationManagerDelegate {

    @IBOutlet var imgBackground: UIImageView!
    @IBOutlet var viewDateTime: UIView!
    @IBOutlet var menuCollection: UICollectionView!
    @IBOutlet var vwBottom: UIView!
    @IBOutlet var bottomCollectionView: UICollectionView!
    @IBOutlet var lblTemp: UILabel!
    @IBOutlet var imgWeather: UIImageView!
    @IBOutlet var lblDateDay: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var btnSettings: UIButton!
    @IBOutlet var vwMessageScroll: UIView!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var vwSettings: UIView!
    @IBOutlet var tblSettings: UITableView!
    
    var arrMenuItem = ["DLScan","DeskLog","Quote","Inventory","Customers","Tasks","appointments","Report","Routes", "Trivia","Music","health"]
    var arrMenuLbl = ["DLScan", "Desk Log", "Quotes", "Inventory", "Customer", "Tasks", "Appts", "Report", "Routes", "Trivia", "Music", "Health"]
    var arrTblMenuItem = ["DLScan","DeskLog","Quote","Inventory","Customers","Tasks","appointments","Report","Routes", "Trivia","Music","health"]
    var arrTblMenuLbl = ["DLScan", "Desk Log", "Quotes", "Inventory", "Customer", "Tasks", "Appts", "Report", "Routes", "Trivia", "Music", "Health"]
    var arrBottomItem = ["Phone","Chat","list","Message"]
    var transperentView = UIView()
    let locManager = CLLocationManager()
    var lat: Double!
    var long: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuCollection.register(UINib(nibName: "DashboardCell", bundle: nil), forCellWithReuseIdentifier: "dashboardCell")
        self.menuCollection.delegate = self
        self.menuCollection.dataSource = self
        self.menuCollection.tag = 1
        
        self.bottomCollectionView.register(UINib(nibName: "DashboardBottomCell", bundle: nil), forCellWithReuseIdentifier: "dashboardBottomCell")
        self.bottomCollectionView.delegate = self
        self.bottomCollectionView.dataSource = self
        self.bottomCollectionView.tag = 2

        self.tblSettings.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "settingsCell")
        self.tblSettings.dataSource = self
        self.tblSettings.delegate = self
        self.tblSettings.tableFooterView = UIView()
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.locManager.delegate = self
            self.locManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locManager.distanceFilter = kCLDistanceFilterNone
            self.locManager.requestWhenInUseAuthorization()
            self.locManager.requestAlwaysAuthorization()
            self.locManager.startMonitoringSignificantLocationChanges()
            self.locManager.startUpdatingLocation()
        } else {
            print("Location services are not enabled");
        }
        
        self.lblMessage.text = "lalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalala"
        self.setUpDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        UIView.animate(withDuration: 7.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
                self.lblMessage.center = CGPoint(x: 0 - self.lblMessage.bounds.size.width, y: self.lblMessage.center.y)
        }, completion:  { _ in })
        self.vwSettings.layer.cornerRadius = 7
        self.tblSettings.scrollToRow(at: IndexPath(item: self.arrMenuItem.count-1, section: 0), at: .bottom, animated: false)
        self.vwSettings.frame = CGRect(x: 20, y: 30, width: ScreenWidth - 40, height: Screenheight-60)
    }

    func setUpDate(){
        let date = NSDate() as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = dateFormatter.string(from: date)
        self.lblDateDay.text = self.getDayOfWeekString(today: dateString)
        
        dateFormatter.dateFormat = "hh:mm a"
        self.lblTime.text = dateFormatter.string(from: date)
    }
    
    func getDayOfWeekString(today:String)->String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.date(from: today) {
            let myCalendar = Calendar(identifier: .gregorian)
            let myDayComponents = myCalendar.component(.weekday, from: todayDate)
            let myMonthComponents = myCalendar.component(.month, from: todayDate)
            let monthName: String = formatter.monthSymbols[(myMonthComponents - 1)]
            switch myDayComponents {
                case 1:
                    return "Sun,\(monthName) \(myCalendar.component(.day, from: todayDate))"
                case 2:
                    return "Mon,\(monthName) \(myCalendar.component(.day, from: todayDate))"
                case 3:
                    return "Tue,\(monthName) \(myCalendar.component(.day, from: todayDate))"
                case 4:
                    return "Wed,\(monthName) \(myCalendar.component(.day, from: todayDate))"
                case 5:
                    return "Thu,\(monthName) \(myCalendar.component(.day, from: todayDate))"
                case 6:
                    return "Fri,\(monthName) \(myCalendar.component(.day, from: todayDate))"
                case 7:
                    return "Sat,\(monthName) \(myCalendar.component(.day, from: todayDate))"
                default:
                    print("Error fetching days")
                    return "Day"
            }
        } else {
            return nil
        }
    }
    
    // MARK:- CollectionView Method(s)
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return arrMenuItem.count
        } else {
            return arrBottomItem.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath) as! DashboardCell
            cell.imgItem.image = UIImage(named: self.arrMenuItem[indexPath.row])
            cell.lblItem.text = arrMenuLbl[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardBottomCell", for: indexPath) as! DashboardBottomCell
            cell.imgBottom.image = UIImage(named: arrBottomItem[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1{
            print("Menu Item selected")
        } else {
            print("Bottom item Selected")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView.tag == 1{
            let size: CGFloat = ScreenWidth/4
            return CGSize(width: size, height: size)
        } else {
            let widthSize: CGFloat = self.vwBottom.frame.width/4
            let heightSize: CGFloat = self.vwBottom.frame.height - 5
            return CGSize(width: widthSize, height: heightSize)
        }
    }
    
    // MARK:- tableView Method(s)

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTblMenuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsCell
        cell.setUpCustom(tableView: tableView, indexPath: indexPath, itemName: self.arrMenuLbl[indexPath.row], itemIcon: self.arrMenuItem[indexPath.row], CustomDelegate: self)
        cell.imgItem.image = UIImage(named: self.arrMenuItem[indexPath.row])
        cell.lblItem.text = self.arrMenuLbl[indexPath.row]
        return cell
    }
    
    func SettingsDidSelectTableViewCell(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath, item: String, icon: String, type: String) {
        if type == "Checked" {
            self.arrMenuLbl = self.arrMenuLbl.filter() {$0 != item}
            self.arrMenuItem = self.arrMenuItem.filter() {$0 != icon}
            self.menuCollection.reloadData()
        } else if type == "Unchecked" {
            self.arrMenuLbl.append(item)
            self.arrMenuItem.append(icon)
            self.menuCollection.reloadData()

        }
    }
    
    // MARK:- Get Location of User
    
    func setIcon(weatherIcon: String) -> String{
        switch(weatherIcon){
        case "clear-day":
            return "haze"
        case "partly-cloudy-day":
            return "partly_cloudy_(day)"
        case "partly-cloudy-night":
            return "partly_cloudy_(night)"
        case "clear-night":
            return "clear_(night)"
        case "rain":
            return "drizzle"
        default :
            return "hail"
        }
    }
    
    func setWeatherData(lat: Double,long:Double){
        let url = URL(string: "https://api.darksky.net/forecast/e700e63b23dc86aa7f29a90be4c5fc2e/\(lat),\(long)")
        let req = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
            data,res,err in
            if(err != nil)
            {
                return
            }
            do {
                if let json:NSMutableDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableDictionary
                {
                    if let tempDict = json.value(forKey: "currently"){
                        if let temp = (tempDict as AnyObject).value(forKey: "temperature"){
                            self.lblTemp.text = "\(temp as! Int) ℃"
                            print("\(temp as! Int) ℃")
                            
                        }
                        if let tempIcon = (tempDict as AnyObject).value(forKey: "icon"){
                            self.imgWeather.image = UIImage(named: self.setIcon(weatherIcon: tempIcon as! String))
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
                return
            }
        })
        task.resume()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        self.setWeatherData(lat: coord.latitude, long: coord.longitude)
        print("longitude:\(coord.longitude)")
        print("latitude:\(coord.latitude)")
//        self.locManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locManager.stopUpdatingLocation()
        print("ERROR:\(error)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleBtnSettings(_ sender: Any) {
        transperentView = UIView(frame: UIScreen.main.bounds)
        transperentView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
        if !self.view.subviews.contains(transperentView) {
            self.view.addSubview(transperentView)
        }
        view.addSubview(self.vwSettings)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler))
        tap.cancelsTouchesInView = false
        self.transperentView.addGestureRecognizer(tap)
    }
    
    func tapHandler(){
        if self.view.subviews.contains(self.vwSettings){
            self.vwSettings.removeFromSuperview()
        }
        if self.view.subviews.contains(transperentView){
            transperentView.removeFromSuperview()
        }
    }
}
