//
//  MatchesDetailCell.swift
//  BestBrain
//
//  Created by sparth on 2/8/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class MatchesDetailCell: UITableViewCell {

    @IBOutlet var imgUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellInterface() {
        imgUser.layer.cornerRadius = self.imgUser.frame.width/2
        imgUser.clipsToBounds = true
    }
    
}
