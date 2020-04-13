//
//  StateWiseDataModel.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class StateWiseDataModel: NSObject {

    var active = 0
    var confirmed = 0
    var deaths = 0
    var deltaConfirmed = 0
    var deltaDeaths = 0
    var deltaRecovered = 0
    var lastUpdatedTime = ""
    var recovered = 0
    var state = ""
    var stateCode = ""
    var stateNotes = ""
    
    init(json : [String : Any]) {
        
        if let value = json["active"] as? Int {
            self.active = value
        }
        
        if let value = json["confirmed"] as? Int {
            self.confirmed = value
        }
        
        if let value = json["deaths"] as? Int {
            self.deaths = value
        }
        
        if let value = json["deltaconfirmed"] as? Int {
            self.deltaConfirmed = value
        }
        
        if let value = json["deltadeaths"] as? Int {
            self.deltaDeaths = value
        }
        
        if let value = json["deltarecovered"] as? Int {
            self.deltaRecovered = value
        }
        
        if let value = json["lastupdatedtime"] as? String {
            self.lastUpdatedTime = value
        }
        
        if let value = json["recovered"] as? Int {
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
