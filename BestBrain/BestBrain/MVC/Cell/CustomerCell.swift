//
//  CustomerCell.swift
//  BestBrain
//
//  Created by sparth on 2/7/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class CustomerCell: UITableViewCell {
    
    @IBOutlet var imgCustomer: UIImageView!
    @IBOutlet var lblCustomerName: UILabel!
    @IBOutlet var btnCheckbox: UIButton!
    
    var displayLink: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnCheckbox.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- IBOutlet Method(s)
    
    @IBAction func handlebtnCheckbox(_ sender: Any) {
        if self.displayLink {
            self.displayLink = false
            self.btnCheckbox.setImage(UIImage(named: "Checked"), for: .normal)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LinkRelationship"), object: nil)
        } else {
            self.displayLink = true
            self.btnCheckbox.setImage(UIImage(named: "Unchecked"), for: .normal)
        }
    }
    
    // MARK:- Custom Method(s)
    
    func setCellInterface() {
        imgCustomer.layer.cornerRadius = imgCustomer.frame.size.width/2
        imgCustomer.clipsToBounds = true
    }
    
}
