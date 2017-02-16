//
//  SettingsCell.swift
//  BestBrain
//
//  Created by Devloper30 on 31/01/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

@objc protocol SettingsTableviewDelagate {
    @objc optional func SettingsDidSelectTableViewCell(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath, item: String, icon: String, type:String)
}

class SettingsCell: UITableViewCell {

    @IBOutlet var imgItem: UIImageView!
    @IBOutlet var lblItem: UILabel!
    @IBOutlet var btnBox: UIButton!

    var displayItem: Bool = true
    var indexPath: IndexPath!
    var itemName: String!
    var itemIcon: String!
    var Celldelegate : SettingsTableviewDelagate!
    var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCustom(tableView: UITableView,indexPath: IndexPath,itemName: String, itemIcon: String,CustomDelegate : SettingsTableviewDelagate) {
        self.Celldelegate = CustomDelegate
        self.indexPath = indexPath
        self.itemName = itemName
        self.itemIcon = itemIcon
        self.tableView = tableView
    }
    
    @IBAction func handleBtnBox(_ sender: UIButton) {
        if sender.tag == 1 {
            if self.displayItem {
                self.displayItem = false
                self.btnBox.setImage(UIImage(named: "Checked"), for: .normal)
                Celldelegate.SettingsDidSelectTableViewCell?(tableView: self.tableView, didSelectRowAtIndexPath: self.indexPath, item: self.itemName, icon: self.itemIcon, type : "Checked")
            } else {
                self.displayItem = true
                self.btnBox.setImage(UIImage(named: "Unchecked"), for: .normal)
                Celldelegate.SettingsDidSelectTableViewCell?(tableView: self.tableView, didSelectRowAtIndexPath: self.indexPath, item: self.itemName, icon: self.itemIcon, type : "Unchecked")
            }
        } else if sender.tag == 2 {
            if self.displayItem {
                self.displayItem = false
                self.btnBox.setImage(UIImage(named: "Checked"), for: .normal)
            } else {
                self.displayItem = true
                self.btnBox.setImage(UIImage(named: "Unchecked"), for: .normal)
            }
        }
    }
 }
