//
//  ResourcesPresenter.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation

protocol ResourcesPresenterDelegate : AnyObject {
    func failure(message: String)
    func success()
}

class ResourcesPresenter {
    
    var resourcesData = [ResourcesModel]()
    
    weak var view  : ResourcesPresenterDelegate?
    init(view: ResourcesPresenterDelegate) {
        self.view = view
    }
    
    func getResources() {
        
        UserApi.sharedInstance.getResources(callback: { [weak self] response , error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let resourcesArrayJson = response["resources"] as? [[String : Any]], resourcesArrayJson.count > 0  else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.resourcesData.removeAll()
            for resource in resourcesArrayJson{
                self?.resourcesData.append(ResourcesModel(json: resource))
            }
            self?.view?.success()
        })
    }
}
