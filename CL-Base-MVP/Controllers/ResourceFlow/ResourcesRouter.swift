//
//  ResourcesRouter.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import Foundation
import UIKit

class ResourcesRouter: Router {
    
    weak internal var view: UIViewController?
    required init(with view: UIViewController) {
        self.view = view
    }
    
    static func ResourcesVC() -> ResourcesViewController? {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "ResourcesViewController") as? ResourcesViewController else {
            return nil
        }
        return vc
    }
}
