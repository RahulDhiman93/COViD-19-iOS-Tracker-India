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
