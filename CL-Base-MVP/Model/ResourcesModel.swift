//
//  ResourcesModel.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class ResourcesModel: NSObject {
 
    var category = ""
    var city = ""
    var contact = ""
    var resourceDescription = ""
    var NGOname = ""
    var phoneNumber = ""
    var state = ""
    
    init(json : [String : Any]) {
        
        if let value = json["category"] as? String {
            self.category = value
        }
        
        if let value = json["city"] as? String {
            self.city = value
        }
        
        if let value = json["contact"] as? String {
            self.contact = value
        }
        
        if let value = json["descriptionandorserviceprovided"] as? String {
            self.resourceDescription = value
        }
        
        if let value = json["nameoftheorganisation"] as? String {
            self.NGOname = value
        }
        
        if let value = json["phonenumber"] as? String {
            self.phoneNumber = value
        }
        
        if let value = json["state"] as? String {
            self.state = value
        }
        
    }
}
