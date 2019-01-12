//
//  ItemCell.swift
//  Homepwner
//
//  Created by Sam Reaves on 1/12/19.
//  Copyright © 2019 Sam Reaves Digital. All rights reserved.
//

import UIKit

class ItemCell : UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /* Adjust dynamic text sizes onload */
        nameLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
    }
}
