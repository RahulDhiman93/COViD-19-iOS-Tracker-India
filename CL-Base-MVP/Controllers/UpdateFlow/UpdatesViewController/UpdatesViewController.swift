//
//  UpdatesViewController.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class UpdatesViewController: UIViewController {
    
    @IBOutlet weak var updatesTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var presenter : UpdatesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = UpdatesPresenter(view: self)
        self.setupTableView()
        self.getUpdates()
        // Do any additional setup after loading the view.
    }

    private func setupTableView() {
        self.updatesTableView.delegate = self
        self.updatesTableView.dataSource = self
        self.updatesTableView.bounces = true
        self.updatesTableView.separatorStyle = .none
        self.updatesTableView.showsVerticalScrollIndicator = false
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.updatesTableView.contentInset = insets
        self.updatesTableView.register(UINib(nibName: "TextViewTableViewCell", bundle: nil), forCellReuseIdentifier: "TextViewTableViewCell")
        refreshControl.addTarget(self, action: #selector(self.getUpdates), for: UIControl.Event.valueChanged)
        self.updatesTableView.addSubview(refreshControl)
        
    }
    
    @objc private func getUpdates() {
        presenter.getUpdatesLog()
    }
}

extension UpdatesViewController : UpdatesPresenterDelegate {
    
    func failure(message: String) {
        refreshControl.endRefreshing()
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func success() {
        refreshControl.endRefreshing()
        self.updatesTableView.reloadData()
    }
    
}

extension UpdatesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.updatesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell", for: indexPath) as? TextViewTableViewCell else{
            fatalError()
        }
        cell.configCell(model: presenter.updatesData[indexPath.row])
        return cell
    }
    
}
