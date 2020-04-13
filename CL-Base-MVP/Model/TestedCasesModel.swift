//
//  TestedCasesModel.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class TestedCasesModel: NSObject {
    
    var positivecasesfromsamplesreported = ""
    var samplereportedtoday = ""
    var source = ""
    var testsconductedbyprivatelabs = ""
    var totalindividualstested = 0
    var totalpositivecases = 0
    var totalsamplestested = 0
    var updatetimestamp = ""
    
    init(json : [String : Any]) {
        
        if let value = json["positivecasesfromsamplesreported"] as? String {
            self.positivecasesfromsamplesreported = value
        }
        
        if let value = json["samplereportedtoday"] as? String {
            self.samplereportedtoday = value
        }
        
        if let value = json["source"] as? String {
            self.source = value
        }
        
        if let value = json["testsconductedbyprivatelabs"] as? String {
            self.testsconductedbyprivatelabs = value
        }
        
        if let value = json["totalindividualstested"] as? Int {
            self.totalindividualstested = value
        }
        
        if let value = json["totalpositivecases"] as? Int {
            self.totalpositivecases = value
        }
        
        if let value = json["totalsamplestested"] as? Int {
            self.totalsamplestested = value
        }
        
        if let value = json["updatetimestamp"] as? String {
            self.updatetimestamp = value
        }
    }
    
}
