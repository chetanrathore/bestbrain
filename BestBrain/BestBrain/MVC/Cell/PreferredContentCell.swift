//
//  PreferredContentCell.swift
//  BestBrain
//
//  Created by anuradha on 2/9/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class PreferredContentCell: UITableViewCell {

    @IBOutlet var btnSms: UIButton!
    @IBOutlet var btnEmail: UIButton!
    @IBOutlet var btnPhone: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
