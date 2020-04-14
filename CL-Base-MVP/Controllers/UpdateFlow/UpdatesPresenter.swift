//
//  UpdatesPresenter.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation

protocol UpdatesPresenterDelegate : AnyObject {
    func failure(message: String)
    func success()
}

class UpdatesPresenter {
    
    var updatesData = [UpdatesModel]()
    
    weak var view  : UpdatesPresenterDelegate?
    init(view: UpdatesPresenterDelegate) {
        self.view = view
    }
    
    func getUpdatesLog() {
        
        UserApi.sharedInstance.getUpdates(callback: { [weak self] response, error in
            
            guard let response = response, error == nil , response.count > 0 else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.updatesData.removeAll()
            for updateJson in response {
                self?.updatesData.append(UpdatesModel(json: updateJson))
            }
            self?.updatesData.reverse()
            self?.view?.success()
        })
        
    }
}
