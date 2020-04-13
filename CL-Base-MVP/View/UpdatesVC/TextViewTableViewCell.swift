//
//  TextViewTableViewCell.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var updatesText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    func configCell(model : UpdatesModel) {
        self.updatesText.text = model.update
        let date = Date(timeIntervalSince1970: Double(model.timeStamp))
        let interval = Date().timeIntervalSince(date)
        let secondsInterval = interval
        let minutes = (secondsInterval/60.0)
        let hours = (minutes/60.0)
        
        if hours >= 1.0  {
            let hoursInt = Int(hours.rounded(toPlaces: 0))
            self.timeStamp.text = "About " + "\(hoursInt) Hour ago"
        } else if minutes > 0.0 {
            let minuteInt = Int(minutes.rounded(toPlaces: 0))
            self.timeStamp.text = "\(minuteInt) Mintutes ago"
        } else if secondsInterval > 0.0 {
            let secondInt = Int(secondsInterval.rounded(toPlaces: 0))
            self.timeStamp.text = "\(secondInt) Seconds ago"
        }
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
