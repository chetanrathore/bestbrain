//
//  NewContactVC.swift
//  BestBrain
//
//  Created by Developer49 on 1/30/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class NewContactVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet var vwTextFields: [UIView]!
    @IBOutlet var imgUser: UIImageView!

    @IBOutlet var tblAddItems: UITableView!
    
    var allItems = [addItems]()
    
//    var arrPhones = [String]()
//    var arrEmails = [String]()
//    var arrDesiredVehicals = [String]()
//    var arrTrades = [String]()
//    var arrShare = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        arrPhones.append("")
//        arrEmails.append("")
//        arrDesiredVehicals.append("")
//        arrTrades.append("")
//        arrShare.append("")

        self.loadData()
        tblAddItems.delegate = self
        tblAddItems.dataSource = self
        tblAddItems.register(UINib(nibName: "addItemCell", bundle: nil), forCellReuseIdentifier: "addItemCell")
        // Do any additional setup after loading the view.
    }
    func loadData(){
        allItems = [
            addItems(name: "add phone", items: 1),
            addItems(name: "add email", items: 1),
            addItems(name: "add desired vehical", items: 1),
            addItems(name: "add trade", items: 1),
            addItems(name: "add source", items: 1)
        ]

    }
    override func viewDidAppear(_ animated: Bool) {
        for vw in vwTextFields{
            vw.layer.borderWidth = 1
            vw.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
            vw.layer.cornerRadius = 7
        }
        imgUser.layer.cornerRadius = imgUser.frame.size.width/2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return allItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allItems[section].collapsed!) ? 0 : allItems[section].items
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addItemCell", for: indexPath) as! addItemCell
        cell.txfCell.delegate = self
        cell.btnAddItem.tag = indexPath.section
        cell.btnAddItem.addTarget(self, action: #selector(NewContactVC.btnAddItemClicked(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        headerView.backgroundColor = UIColor.white
        let btn = UIButton(frame: headerView.frame)
        btn.tag = section
        let lblHeader = UILabel(frame: CGRect(x: 30, y: 5, width: headerView.frame.size.width-70, height: 40))
        lblHeader.text = allItems[section].name
        lblHeader.textColor = UIColor.blue
        btn.addTarget(self, action: #selector(NewContactVC.toggleButton), for: .touchUpInside)
        headerView.addSubview(btn)
        headerView.addSubview(lblHeader)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func toggleButton(_ sender: UIButton){
        let section = sender.tag
        let collapsed = allItems[section].collapsed
        
        // Toggle collapse
        allItems[section].collapsed = !collapsed!
        
        // Reload section
        tblAddItems.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    func btnAddItemClicked(_ sender: UIButton){
        let tag = sender.tag
//        if tag > 0{
//            let cell = tblAddItems.cellForRow(at: IndexPath(index: tag-1)) as! addItemCell
//            cell.btnAddItem.isHidden = true
//        }
        allItems[tag].items = allItems[tag].items+1
        tblAddItems.reloadData()
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
class addItems{
    var name: String!
    var items: Int!
    var collapsed: Bool!
    
    init(name: String, items: Int, collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }

}
