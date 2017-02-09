//
//  PossibleMatchesVC.swift
//  BestBrain
//
//  Created by LaNet on 2/8/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class PossibleMatchesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tblPossiblematches: UITableView!
    var arrMatches = [String]()
    
    var isDisData = NSMutableArray()
    var editIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        tblPossiblematches.dataSource = self
        tblPossiblematches.delegate = self
        
        arrMatches.append("Test1")
        arrMatches.append("Test1")
        arrMatches.append("Test1")
        arrMatches.append("Test1")
        arrMatches.append("Test1")
        arrMatches.append("Test1")
        arrMatches.append("Test1")
        arrMatches.append("Test1")
        
        tblPossiblematches.register(UINib(nibName: "MatchesDetailCell", bundle: nil), forCellReuseIdentifier: "MatchesDetailCell")
        setDisArr()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrMatches.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 50)
        header.backgroundColor = UIColor.white
        
        let bottom = UIView()
        bottom.frame = CGRect(x: 20, y: 48, width: UIScreen.main.bounds.width - 40, height: 2)
        bottom.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 100 , height: 20)
        label.text = "Test data"
        label.textColor = UIColor.black
        
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: header.bounds.width - 20, height: header.bounds.height)
        btn.addTarget(self, action: #selector(btnExpand), for: .touchUpInside)
        btn.tag = section
        btn.backgroundColor = UIColor.clear
        btn.setTitleColor(UIColor.gray, for: .normal)
        if(self.isDisData.object(at: section) as! Bool){
            btn.setImage(UIImage(named: "collapse.png"), for: .normal)
        }else{
            btn.setImage(UIImage(named: "expand.png"), for: .normal)
            header.addSubview(bottom)
        }
        btn.contentHorizontalAlignment =  UIControlContentHorizontalAlignment.right
        header.addSubview(btn)
        header.addSubview(label)
        return header
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.isDisData.object(at: section) as! Bool){
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesDetailCell", for: indexPath) as! MatchesDetailCell
        cell.setCellInterface()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func setDisArr(){
        for i in 0..<self.arrMatches.count{
            self.isDisData.insert(false, at: i)
        }
    }
    
    func btnExpand(sender: UIButton){
        let section = sender.tag
        if(self.isDisData.object(at: section) as! Bool){
            self.isDisData.replaceObject(at: section, with: false)
        }else{
            self.isDisData.replaceObject(at: section, with: true)
        }
        self.tblPossiblematches.reloadSections([section], with: .fade)
        
    }
    
}
