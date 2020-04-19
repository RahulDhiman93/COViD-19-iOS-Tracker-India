//
//  PrecautionViewController.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 15/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class PrecautionViewController: UIViewController {
    
    @IBOutlet weak var precautionsTableView: UITableView!
    
    var presenter : PrecautionPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PrecautionPresenter(view: self)
        self.setupTableView()
        // Do any additional setup after loading the view.
    }

    private func setupTableView() {
        self.precautionsTableView.delegate = self
        self.precautionsTableView.dataSource = self
        self.precautionsTableView.bounces = true
        self.precautionsTableView.separatorStyle = .none
        self.precautionsTableView.showsVerticalScrollIndicator = false
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.precautionsTableView.contentInset = insets
        self.precautionsTableView.register(UINib(nibName: "MaintainTableViewCell", bundle: nil), forCellReuseIdentifier: "MaintainTableViewCell")
        self.precautionsTableView.register(UINib(nibName: "CompanyInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyInfoTableViewCell")
        self.precautionsTableView.register(UINib(nibName: "ContactDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactDetailTableViewCell")
        
        
    }
}

extension PrecautionViewController : PrecautionPresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
}

extension PrecautionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Precaution_Sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Precaution_Sections(rawValue: indexPath.section) {
        case .recommend:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MaintainTableViewCell", for: indexPath) as? MaintainTableViewCell else{
                fatalError()
            }
            return cell
        case .contactInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailTableViewCell", for: indexPath) as? ContactDetailTableViewCell else{
                fatalError()
            }
            cell.delegate = self
            return cell
        case .companyInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as? CompanyInfoTableViewCell else{
                fatalError()
            }
            return cell
        case .none:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Precaution_Sections(rawValue: indexPath.section) {
        case .recommend:
            return 400.0
        case .contactInfo:
            return UITableView.automaticDimension
        case .companyInfo:
            return 175.0
        case .none:
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 222, green: 222, blue: 222)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch Precaution_Sections(rawValue: section) {
        case .recommend:
            return 0.001
        default:
            return 10.0
        }
    }
}

extension PrecautionViewController : ContactDetailTableViewCellDelegate {
    
    func phoneAction(number: String) {
        let phone = number.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func emailAction(mailId: String) {
        let email = mailId
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func appOpen(link: String) {
        guard let url = URL(string: link) else { return }
        let application = UIApplication.shared
        if application.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                application.open(url)
            } else {
                application.openURL(url)
            }
        }
    }
    
    func openInsta(id: String) {
        let Username = id
        let appURL = URL(string: "instagram://user?username=\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                application.open(appURL)
            } else {
                application.openURL(appURL)
            }
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string: "https://instagram.com/\(Username)")!
            if #available(iOS 10.0, *) {
                application.open(webURL)
            } else {
                application.openURL(webURL)
            }
        }
    }

}
