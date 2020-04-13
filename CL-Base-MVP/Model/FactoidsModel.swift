//
//  FactoidsModel.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class FactoidsModel: NSObject {

    var id = ""
    var banner = ""
    
    init(json : [String : Any]) {
        
        if let value = json["id"] as? String {
            self.id = value
        }
        
        if let value = json["banner"] as? String {
            self.banner = value
        }
        
    }
    
}
