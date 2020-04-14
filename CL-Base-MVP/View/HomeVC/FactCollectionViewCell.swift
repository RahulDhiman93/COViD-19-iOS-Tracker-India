//
//  FactCollectionViewCell.swift
//  covid-19-IND
//
//  Created by Rahul Dhiman on 14/04/20.
//  Copyright © 2020 Deepak. All rights reserved.
//

import UIKit

class FactCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var factText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.factText.numberOfLines = 0
        // Initialization code
    }
    
    func configCell(fact : String) {
        self.factText.text = fact
        
    }

}
