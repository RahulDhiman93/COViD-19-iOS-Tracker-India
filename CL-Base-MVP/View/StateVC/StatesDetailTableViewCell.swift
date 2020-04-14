//
//  StatesDetailTableViewCell.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class StatesDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stateNameAndCode: UILabel!
    @IBOutlet weak var updateTimeText: UILabel!
    

    @IBOutlet weak var deltaConfirmed: UILabel!
    @IBOutlet weak var totalConfirmed: UILabel!
    
    @IBOutlet weak var totalActive: UILabel!
    
    @IBOutlet weak var deltaRecovered: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    
    @IBOutlet weak var deltaDeceased: UILabel!
    @IBOutlet weak var totalDeceased: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    func configCell(model : StateWiseDataModel) {
        self.stateNameAndCode.text = model.state + " " + "(\(model.stateCode))"
        self.totalConfirmed.text = model.confirmed
        self.totalActive.text = model.active
        self.totalRecovered.text = model.recovered
        self.totalDeceased.text = model.deaths
        
        if let deltaCON = Int(model.deltaConfirmed), deltaCON > 0 {
            self.deltaConfirmed.text = "↑" + model.deltaConfirmed
        } else {
            self.deltaConfirmed.text = ""
        }
        
        if let deltaREC = Int(model.deltaRecovered), deltaREC > 0 {
            self.deltaRecovered.text = "↑" + model.deltaRecovered
        } else {
            self.deltaRecovered.text = ""
        }
        
        if let deltaDEC = Int(model.deltaDeaths), deltaDEC > 0 {
            self.deltaDeceased.text = "↑" + model.deltaDeaths
        } else {
            self.deltaDeceased.text = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        guard let date = dateFormatter.date(from: model.lastUpdatedTime) else {
            self.updateTimeText.text = ""
            return
        }
        let interval = Date().timeIntervalSince(date)
        let secondsInterval = interval
        let minutes = (secondsInterval/60.0)
        let hours = (minutes/60.0)
        
        if hours >= 1.0  {
            let hoursInt = Int(hours.rounded(toPlaces: 0))
            self.updateTimeText.text = "Updated " + "\(hoursInt) Hour ago"
        } else if minutes > 0.0 {
            let minuteInt = Int(minutes.rounded(toPlaces: 0))
            self.updateTimeText.text = "Updated " + "\(minuteInt) Mintutes ago"
        } else if secondsInterval > 0.0 {
            let secondInt = Int(secondsInterval.rounded(toPlaces: 0))
            self.updateTimeText.text = "Updated " + "\(secondInt) Seconds ago"
        } else {
            self.updateTimeText.text = ""
        }
        
        self.layoutIfNeeded()
    }
}
