//
//  SplashViewController.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var hudView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension SplashViewController {
    
    private func fetchAppInfo() {
        self.hudView.startAnimating()
        UserApi.sharedInstance.getAppInfo(callback: { [weak self] response , error in
            self?.hudView.stopAnimating()
            
            
            
        })
        
    }
    
}
