//
//  SideMenuCell.swift
//  BestBrain
//
//  Created by Devloper30 on 17/02/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet var imgItem: UIImageView!
    @IBOutlet var lblItem: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
