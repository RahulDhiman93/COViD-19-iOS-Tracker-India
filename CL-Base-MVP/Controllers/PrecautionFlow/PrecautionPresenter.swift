//
//  PrecautionPresenter.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 15/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation

protocol PrecautionPresenterDelegate : AnyObject {
    func failure(message: String)
}

class PrecautionPresenter {
    
    weak var view  : PrecautionPresenterDelegate?
    init(view: PrecautionPresenterDelegate) {
        self.view = view
    }
    
}

enum Precaution_Sections : Int {
    case recommend = 0
    case companyInfo
    static let count = companyInfo.rawValue + 1
}
