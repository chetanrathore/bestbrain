//
//  Customer.swift
//  BestBrain
//
//  Created by LaNet on 2/7/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import Foundation

class Customer {
    var firstName: String?
    var lastName: String?
    var ciry: String?
    
    init() {
        self.firstName = "N/A"
        self.lastName = "N/A"
        self.ciry = "N/A"
    }
    
    init(firstName: String, lastName: String, city: String) {
            self.firstName = firstName
            self.lastName = lastName
            self.ciry = city
    }

}
