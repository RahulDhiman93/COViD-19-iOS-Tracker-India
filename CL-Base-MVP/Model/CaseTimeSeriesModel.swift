//
//  CaseTimeSeriesModel.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class CaseTimeSeriesModel: NSObject {

    var dailyconfirmed = 0
    var dailydeceased = 0
    var dailyrecovered = 0
    var dailyactive = 0
    var date = ""
    var totalconfirmed = 0
    var totaldeceased = 0
    var totalrecovered = 0
    var totalactive = 0
    
    init(json : [String : Any]){
        
        if let value = json["dailyconfirmed"] as? String {
            if let value = Int(value) {
                self.dailyconfirmed = value
            }
        }
        
        if let value = json["dailydeceased"] as? String {
            if let value = Int(value) {
                self.dailydeceased = value
            }
        }
        
        if let value = json["dailyrecovered"] as? String {
            if let value = Int(value) {
                self.dailyrecovered = value
            }
        }
        
        if let value = json["date"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            if let date = dateFormatter.date(from: value) {
                var dateString = ""
                dateFormatter.dateFormat = "dd"
                dateString = dateFormatter.string(from: date)
                dateFormatter.dateFormat = "MMMM"
                self.date = dateString + " " + dateFormatter.string(from: date)
            } else {
                self.date = value
            }
        }
        
        if let value = json["totalconfirmed"] as? String {
            if let value = Int(value) {
                self.totalconfirmed = value
            }
        }
        
        if let value = json["totaldeceased"] as? String {
            if let value = Int(value) {
                self.totaldeceased = value
            }
        }
        
        if let value = json["totalrecovered"] as? String {
            if let value = Int(value) {
                self.totalrecovered = value
            }
        }
        
        self.dailyactive = self.dailyconfirmed - self.dailydeceased - self.dailyrecovered
        self.totalactive = self.totalconfirmed - self.totaldeceased - self.totalrecovered
    }
    
}
