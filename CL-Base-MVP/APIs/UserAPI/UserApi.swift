//
//  UserApi.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class UserApi: NSObject {
   static let sharedInstance = UserApi()
}

extension UserApi {
    
    func getHomeData(callback: @escaping (_ response: [String:Any]?, _ error: Error?) -> Void) {
        
        let path = AppConstants.currentServer + "data.json"
        
        HTTPRequest(method: .get, fullURLStr: path, parameters: nil, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: false)
            .handler(httpModel: false, delay: 0) { (response) in
                
                print(response as Any)
                //  print(error as Any)
                
                if response.error != nil {
                    callback(nil, response.error)
                    return
                }
                
                guard let value = response.value else {
                    callback(nil, nil)
                    return
                }
                
                if let json = value as? [String : Any] ,
                    let statusCode = json["status"] as? Int {
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE || statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [String: Any] {
                            callback(jsonObject, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                } else {
                    if let jsonObject = value as? [String: Any] {
                        callback(jsonObject, nil)
                    } else {
                        callback(nil, nil)
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
    func getUpdates(callback: @escaping (_ response: [[String:Any]]?, _ error: Error?) -> Void) {
        
        let path = AppConstants.currentServer + "updatelog/log.json"
        
        HTTPRequest(method: .get, fullURLStr: path, parameters: nil, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: false)
            .handler(httpModel: false, delay: 0) { (response) in
                
                print(response as Any)
                //  print(error as Any)
                
                if response.error != nil {
                    callback(nil, response.error)
                    return
                }
                
                guard let value = response.value else {
                    callback(nil, nil)
                    return
                }
                
                if let json = value as? [String : Any] ,
                    let statusCode = json["status"] as? Int {
                    
                    if statusCode == STATUS_CODES.BAD_REQUEST || statusCode == STATUS_CODES.ERROR_IN_EXECUTION || statusCode == STATUS_CODES.SHOW_MESSAGE || statusCode == STATUS_CODES.UNAUTHORIZED_ACCESS{
                        if let errorMessage = json["message"] as? String {
                            let callBackError = NSError(domain:"", code: statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
                            callback(nil, callBackError)
                        } else {
                            callback(nil,nil)
                        }
                        return
                    } else if statusCode == STATUS_CODES.SHOW_DATA {
                        if let jsonObject = value as? [[String: Any]] {
                            callback(jsonObject, nil)
                        } else {
                            callback(nil, nil)
                        }
                    }
                } else {
                    if let jsonObject = value as? [[String: Any]] {
                        callback(jsonObject, nil)
                    } else {
                        callback(nil, nil)
                    }
                }
                
        }//HTTP REQUEST END
        
    }// API FUNC END
    
}
