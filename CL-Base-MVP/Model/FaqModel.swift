//
//  FaqModel.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class FaqModel: NSObject {

    var qno = ""
    var question = ""
    var answer = ""
    
    init(json : [String : Any]) {
        
        if let value = json["qno"] as? String{
            self.qno = value
        }
        
        if let value = json["question"] as? String{
            self.question = value
        }
        
        if let value = json["answer"] as? String{
            self.answer = value
        }
        
    }
}
