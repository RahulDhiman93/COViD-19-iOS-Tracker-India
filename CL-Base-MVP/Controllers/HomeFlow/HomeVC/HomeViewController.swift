//
//  HomeViewController.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 13/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Selected date outlet
    @IBOutlet weak var casesForDate: UILabel!
    
    //MARK: Data for selected date outlet
    @IBOutlet weak var confirmedCasesForDate: UILabel!
    @IBOutlet weak var activeCasesForDate: UILabel!
    @IBOutlet weak var recoveredCasesForDate: UILabel!
    @IBOutlet weak var deceasedCasesForDate: UILabel!
    
    //MARK: Data for total cases outlet
    @IBOutlet weak var totalConfirmedCases: UILabel!
    @IBOutlet weak var totalActiveCases: UILabel!
    @IBOutlet weak var totalRecoveredCases: UILabel!
    @IBOutlet weak var totalDeceasedCases: UILabel!
    
    var presenter : HomePresenter!
    var pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(view: self)
        self.setupView()
        presenter.getHomeData()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setupView() {
        self.confirmedCasesForDate.text = "+0"
        self.activeCasesForDate.text = "+0"
        self.recoveredCasesForDate.text = "+0"
        self.deceasedCasesForDate.text = "+0"
        
        self.totalConfirmedCases.text = "0"
        self.totalActiveCases.text = "0"
        self.totalRecoveredCases.text = "0"
        self.totalDeceasedCases.text = "0"
    }
    
    
    @IBAction func changeDateAction(_ sender: UIButton) {
        self.pickerView.frame = self.view.bounds
        self.pickerView.backgroundColor = .white
        UIView.animate(withDuration: 0.5, animations: {
            self.view.addSubview(self.pickerView)
        })
        pickerView.becomeFirstResponder()
    }
    
}

extension HomeViewController : HomePresenterDelegate {
    
    func failure(message: String) {
        ErrorView.showWith(message: message, isErrorMessage: true) {}
    }
    
    func homeDataSuccess() {
        guard let selectedCaseData = presenter.selectedCaseData else { return }
        let animationTime = 1.0
        
        UIView.animate(withDuration: animationTime, animations: {
            self.casesForDate.text = selectedCaseData.date
            self.view.layoutIfNeeded()
        })
        
        UIView.transition(with: confirmedCasesForDate, duration: animationTime, options: .transitionFlipFromBottom, animations: {
            self.confirmedCasesForDate.text = "+" +  "\(selectedCaseData.dailyconfirmed)"
        })
        
        UIView.transition(with: activeCasesForDate, duration: animationTime, options: .transitionFlipFromBottom, animations: {
            self.activeCasesForDate.text = "+" +  "\(selectedCaseData.dailyactive)"
        }, completion: nil)
        
        UIView.transition(with: recoveredCasesForDate, duration: animationTime, options: .transitionFlipFromBottom, animations: {
            self.recoveredCasesForDate.text = "+" +  "\(selectedCaseData.dailyrecovered)"
        }, completion: nil)
        
        UIView.transition(with: deceasedCasesForDate, duration: animationTime, options: .transitionFlipFromBottom, animations: {
            self.deceasedCasesForDate.text = "+" +  "\(selectedCaseData.dailydeceased)"
        }, completion: nil)
        
        
        
        
        UIView.transition(with: totalConfirmedCases, duration: animationTime, options: .transitionFlipFromBottom, animations: {
            self.totalConfirmedCases.text = "\(selectedCaseData.totalconfirmed)"
        }, completion: nil)
        
        UIView.transition(with: totalActiveCases, duration: animationTime, options: .transitionFlipFromBottom, animations: {
            self.totalActiveCases.text = "\(selectedCaseData.totalactive)"
        }, completion: nil)
        
        UIView.transition(with: totalRecoveredCases, duration: animationTime, options: .transitionFlipFromBottom, animations: {
            self.totalRecoveredCases.text = "\(selectedCaseData.totalrecovered)"
        }, completion: nil)
        
        UIView.transition(with: totalDeceasedCases, duration: animationTime, options: .transitionFlipFromBottom, animations: {
            self.totalDeceasedCases.text = "\(selectedCaseData.totaldeceased)"
        }, completion: nil)
        
        
    }
}

extension HomeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.caseTimeSeriesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.caseTimeSeriesData[row].date
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.selectedCaseData = presenter.caseTimeSeriesData[row]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.pickerView.removeFromSuperview()
                self.homeDataSuccess()
            })
        })
        
    }
    
    
}
