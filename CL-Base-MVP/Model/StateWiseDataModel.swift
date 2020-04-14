//
//  StateWiseDataModel.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class StateWiseDataModel: NSObject {

    var active = ""
    var confirmed = ""
    var deaths = ""
    var deltaConfirmed = ""
    var deltaDeaths = ""
    var deltaRecovered = ""
    var lastUpdatedTime = ""
    var recovered = ""
    var state = ""
    var stateCode = ""
    var stateNotes = ""
    
    init(json : [String : Any]) {
        
        if let value = json["active"] as? String {
            self.active = value
        }
        
        if let value = json["confirmed"] as? String {
            self.confirmed = value
        }
        
        if let value = json["deaths"] as? String {
            self.deaths = value
        }
        
        if let value = json["deltaconfirmed"] as? String {
            self.deltaConfirmed = value
        }
        
        if let value = json["deltadeaths"] as? String {
            self.deltaDeaths = value
        }
        
        if let value = json["deltarecovered"] as? String {
            self.deltaRecovered = value
        }
        
        if let value = json["lastupdatedtime"] as? String {
            self.lastUpdatedTime = value
        }
        
        if let value = json["recovered"] as? String {
            self.recovered = value
        }
        
        if let value = json["state"] as? String {
            self.state = value
        }
        
        if let value = json["statecode"] as? String {
            self.stateCode = value
        }
        
        if let value = json["statenotes"] as? String {
            self.stateNotes = value
        }
        
    }
}
