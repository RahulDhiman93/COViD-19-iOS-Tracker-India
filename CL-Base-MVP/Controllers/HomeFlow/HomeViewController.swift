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
    @IBOutlet weak var updatedText: UILabel!
    
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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var presenter : HomePresenter!
    var pickerView = UIPickerView()
    var selectCaseDateRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(view: self)
        self.setupView()
        self.setupCollectionView()
        self.startTimer()
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
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = true
        self.collectionView.isUserInteractionEnabled = false
        self.collectionViewFlowLayout.minimumLineSpacing = 0
        self.collectionViewFlowLayout.minimumInteritemSpacing = 0
        self.collectionView.register(UINib(nibName: "FactCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FactCollectionViewCell")
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
        guard let stateWiseTotal = presenter.stateWiseTotal else { return }
        let animationTime = 1.0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        guard let date = dateFormatter.date(from: stateWiseTotal.lastUpdatedTime) else {
            return
        }
        let interval = Date().timeIntervalSince(date)
        let secondsInterval = interval
        let minutes = (secondsInterval/60.0)
        let hours = (minutes/60.0)

        let isUpdateHidden = selectCaseDateRow == 0 ? false : true
        
        UIView.animate(withDuration: animationTime, animations: {
            self.casesForDate.text = selectedCaseData.date
            self.updatedText.isHidden = isUpdateHidden
            if hours >= 1.0  {
                let hoursInt = Int(hours.rounded(toPlaces: 0))
                self.updatedText.text = "Updated " + "\(hoursInt) Hour ago"
            } else if minutes > 0.0 {
                let minuteInt = Int(minutes.rounded(toPlaces: 0))
                self.updatedText.text = "Updated " + "\(minuteInt) Mintutes ago"
            } else if secondsInterval > 0.0 {
                let secondInt = Int(secondsInterval.rounded(toPlaces: 0))
                self.updatedText.text = "Updated " + "\(secondInt) Seconds ago"
            }
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
        self.selectCaseDateRow = row
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.pickerView.removeFromSuperview()
                self.homeDataSuccess()
            })
        })
        
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppInfoFiles.sharedIntance.factodies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FactCollectionViewCell" , for: indexPath) as? FactCollectionViewCell else {
            fatalError()
        }
        cell.configCell(fact: AppInfoFiles.sharedIntance.factodies[indexPath.item].banner)
        cell.layoutIfNeeded()
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size : CGSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func startTimer() {

        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }


    @objc func scrollAutomatically(_ timer1: Timer) {

        if let coll  = self.collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < AppInfoFiles.sharedIntance.factodies.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)

                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }

            }
        }
    }
    
}
