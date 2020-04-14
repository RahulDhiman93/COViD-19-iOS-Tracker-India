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
        self.fetchAppInfo()
    }
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { fatalError("TabBar Instance failed") }
        vc.selectedIndex = 2
        UIView.transition(with: appDelegate.window!, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = vc
        }, completion: nil)
    }
    
}

extension SplashViewController {
    
    private func fetchAppInfo() {
        self.hudView.startAnimating()
        UserApi.sharedInstance.getAppInfo(callback: { [weak self] response , error in
            self?.hudView.stopAnimating()
            
            guard let response = response, error == nil else {
                self?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let factoids = response["factoids"] as? [[String : Any]] else {
                self?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            guard let faqs = response["faq"] as? [[String : Any]] else {
                self?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            for fact in factoids {
                AppInfoFiles.sharedIntance.factodies.append(FactoidsModel(json: fact))
            }
            
            for faq in faqs {
                AppInfoFiles.sharedIntance.faqs.append(FaqModel(json: faq))
            }
            
            let sb = UIStoryboard(name: "Home", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { fatalError("TabBar Instance failed") }
            vc.selectedIndex = 2
            UIView.transition(with: appDelegate.window!, duration: 1.0, options: .transitionCrossDissolve, animations: {
                appDelegate.window?.rootViewController = vc
            })
        })
        
    }
    
}
