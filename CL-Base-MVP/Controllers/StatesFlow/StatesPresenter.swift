//
//  StatesPresenter.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation

protocol StatesPresenterDelegate : AnyObject {
    func failure(message: String)
    func success()
}

class StatesPresenter {
    
    var stateData = [StateWiseDataModel]()
    
    weak var view  : StatesPresenterDelegate?
    init(view: StatesPresenterDelegate) {
        self.view = view
    }
    
    func getStateUpdates() {
        
        UserApi.sharedInstance.getHomeData(callback: { [weak self] response, error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let stateWiseJsonArray = response["statewise"] as? [[String : Any]], stateWiseJsonArray.count > 0  else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.stateData.removeAll()
            for stateData in stateWiseJsonArray {
                if let code = stateData["statecode"] as? String, code != "TT" {
                    self?.stateData.append(StateWiseDataModel(json: stateData))
                }
            }
            self?.view?.success()
        })
        
    }
}
