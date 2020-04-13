//
//  HomeRouter.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func HomeVC() -> HomeViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            return nil
        }
        vc.presenter = HomePresenter(view: vc)
        return vc
    }
}
