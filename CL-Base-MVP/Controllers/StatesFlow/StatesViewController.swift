//
//  StatesViewController.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class StatesViewController: UIViewController {
    
    @IBOutlet weak var statesTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var presenter : StatesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StatesPresenter(view: self)
        setupTableView()
        getUpdates()
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        self.statesTableView.delegate = self
        self.statesTableView.dataSource = self
        self.statesTableView.bounces = true
        self.statesTableView.separatorStyle = .none
        self.statesTableView.showsVerticalScrollIndicator = false
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.statesTableView.contentInset = insets
        self.statesTableView.register(UINib(nibName: "StatesDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "StatesDetailTableViewCell")
        refreshControl.addTarget(self, action: #selector(self.getUpdates), for: UIControl.Event.valueChanged)
        self.statesTableView.addSubview(refreshControl)
        
    }
    
    @objc private func getUpdates() {
        presenter.getStateUpdates()
    }

}

extension StatesViewController : StatesPresenterDelegate {
    
    func failure(message: String) {
        refreshControl.endRefreshing()
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func success() {
        refreshControl.endRefreshing()
        self.statesTableView.reloadData()
    }
    
}

extension StatesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.stateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatesDetailTableViewCell", for: indexPath) as? StatesDetailTableViewCell else{
            fatalError()
        }
        cell.configCell(model: presenter.stateData[indexPath.row])
        return cell
    }
    
}
