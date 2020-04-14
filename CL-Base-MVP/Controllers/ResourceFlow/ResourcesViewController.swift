//
//  ResourcesViewController.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {

    @IBOutlet weak var resourcesTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var presenter : ResourcesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ResourcesPresenter(view: self)
        self.setupTableView()
        self.getUpdates()
        // Do any additional setup after loading the view.
    }

    private func setupTableView() {
        self.resourcesTableView.delegate = self
        self.resourcesTableView.dataSource = self
        self.resourcesTableView.bounces = true
        self.resourcesTableView.separatorStyle = .none
        self.resourcesTableView.showsVerticalScrollIndicator = false
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.resourcesTableView.contentInset = insets
        self.resourcesTableView.register(UINib(nibName: "ResourcesTableViewCell", bundle: nil), forCellReuseIdentifier: "ResourcesTableViewCell")
        refreshControl.addTarget(self, action: #selector(self.getUpdates), for: UIControl.Event.valueChanged)
        self.resourcesTableView.addSubview(refreshControl)
        
    }
    
    @objc private func getUpdates() {
        presenter.getResources()
    }
}


extension ResourcesViewController : ResourcesPresenterDelegate {
    
    func failure(message: String) {
        refreshControl.endRefreshing()
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func success() {
        refreshControl.endRefreshing()
        self.resourcesTableView.reloadData()
    }
    
}

extension ResourcesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.resourcesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResourcesTableViewCell", for: indexPath) as? ResourcesTableViewCell else{
            fatalError()
        }
        cell.configCell(model: presenter.resourcesData[indexPath.row])
        return cell
    }
    
}
