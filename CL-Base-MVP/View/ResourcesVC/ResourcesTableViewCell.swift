//
//  ResourcesTableViewCell.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class ResourcesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ngoName: UILabel!
    @IBOutlet weak var stateAndCity: UILabel!
    @IBOutlet weak var contactLink: UIButton!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var resDescription: UILabel!
    
    var contactLinkString = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    @IBAction func linkTapped(_ sender: UIButton) {
        guard let url = URL(string: self.contactLinkString) else { return }
        UIApplication.shared.open(url)
    }
    
    func configCell(model : ResourcesModel) {
        self.ngoName.text = model.NGOname
        self.stateAndCity.text = model.city + ", " + model.state
        self.contactLink.setAttributedTitle(NSAttributedString(string: model.contact), for: .normal)
        self.contactLinkString = model.contact
        self.category.text = model.category
        self.phone.text = model.phoneNumber
        self.resDescription.text = model.resourceDescription
    }
}
