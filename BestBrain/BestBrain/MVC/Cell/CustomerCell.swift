//
//  CustomerCell.swift
//  BestBrain
//
//  Created by LaNet on 2/7/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class CustomerCell: UITableViewCell {

    
    @IBOutlet var imgCustomer: UIImageView!
    @IBOutlet var lblCustomerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellInterface() {
        imgCustomer.layer.cornerRadius = 10
        imgCustomer.clipsToBounds = true
    }
    
}
