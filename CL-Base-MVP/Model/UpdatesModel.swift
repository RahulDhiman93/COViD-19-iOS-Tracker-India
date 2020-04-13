//
//  UpdatesModel.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class UpdatesModel: NSObject {
     
    var update = ""
    var timeStamp = 0
    
    init(json : [String : Any]) {
        
        if let value = json["update"] as? String {
            self.update = value
        }
        
        if let value = json["timestamp"] as? Int {
            self.timeStamp = value
        }
        
    }
}
