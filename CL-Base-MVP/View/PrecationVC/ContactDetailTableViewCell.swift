//
//  ContactDetailTableViewCell.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 19/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

protocol ContactDetailTableViewCellDelegate : AnyObject {
    func phoneAction(number : String)
    func emailAction(mailId : String)
    func appOpen(link : String)
    func openInsta(id : String)
}

class ContactDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var app: UILabel!
    @IBOutlet weak var instagram: UILabel!
    
    weak var delegate : ContactDetailTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    @IBAction func phoneTapped(_ sender: UIButton) {
        delegate?.phoneAction(number: "01123978046")
    }
    
    @IBAction func emailTapped(_ sender: UIButton) {
        delegate?.emailAction(mailId: "ncov2019@gov.in")
    }
    
    @IBAction func appTapped(_ sender: UIButton) {
        delegate?.appOpen(link: "https://apps.apple.com/in/app/aarogyasetu/id1505825357")
    }
    
    @IBAction func instgramTapped(_ sender: UIButton) {
        delegate?.openInsta(id: "MyGovIndia")
    }
}
