//
//  HomePresenter.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate : AnyObject {
    func failure(message: String)
    func homeDataSuccess()
}

class HomePresenter {
    
    var caseTimeSeriesData = [CaseTimeSeriesModel]()
    var selectedCaseData : CaseTimeSeriesModel?
    var stateWiseTotal : StateWiseDataModel?
    
    weak var view  : HomePresenterDelegate?
    init(view: HomePresenterDelegate) {
        self.view = view
    }
    
    
    func getHomeData() {
        
        UserApi.sharedInstance.getHomeData(callback: { [weak self] response, error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let caseTimeSeriesJsonArray = response["cases_time_series"] as? [[String : Any]], caseTimeSeriesJsonArray.count > 0  else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let stateWiseJsonArray = response["statewise"] as? [[String : Any]], stateWiseJsonArray.count > 0  else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            let stateWiseTotal = StateWiseDataModel(json: stateWiseJsonArray[0])
            self?.stateWiseTotal = stateWiseTotal
            let dailyJson : [String : Any] = [
                "dailyconfirmed" : stateWiseTotal.deltaConfirmed,
                "dailyrecovered" : stateWiseTotal.deltaRecovered,
                "dailydeceased" : stateWiseTotal.deltaDeaths,
                "date" : stateWiseTotal.lastUpdatedTime,
                "totalconfirmed" : stateWiseTotal.confirmed,
                "totalrecovered" : stateWiseTotal.recovered,
                "totaldeceased" : stateWiseTotal.deaths
            ]
            
            self?.caseTimeSeriesData.removeAll()
            for caseSeries in caseTimeSeriesJsonArray {
                self?.caseTimeSeriesData.append(CaseTimeSeriesModel(json: caseSeries))
            }
            self?.caseTimeSeriesData.append(CaseTimeSeriesModel(json: dailyJson))
            self?.caseTimeSeriesData.reverse()
            self?.selectedCaseData = self?.caseTimeSeriesData[0]
            self?.view?.homeDataSuccess()
        })
        
    }
}
