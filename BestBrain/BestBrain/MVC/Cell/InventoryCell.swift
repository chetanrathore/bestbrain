//
//  InventoryCell.swift
//  BestBrain
//
//  Created by LaNet on 1/30/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {

    
    @IBOutlet var imgInventory: UIImageView!
    
    @IBOutlet var btnView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellInterface() {
        imgInventory.layer.cornerRadius = 10
        btnView.layer.borderWidth = 1
        btnView.layer.borderColor = UIColor.white.cgColor
        btnView.layer.cornerRadius = 4
        btnView.clipsToBounds = true
    }

}
