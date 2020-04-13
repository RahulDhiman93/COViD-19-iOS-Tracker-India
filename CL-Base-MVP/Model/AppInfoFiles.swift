//
//  AppInfoFiles.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class AppInfoFiles: NSObject {
    
    static let sharedIntance = AppInfoFiles()
    var factodies = [FactoidsModel]()
    var faqs = [FaqModel]()
    
}
