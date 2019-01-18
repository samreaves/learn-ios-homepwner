//
//  ItemDetailViewController.swift
//  Homepwner
//
//  Created by Sam Reaves on 1/13/19.
//  Copyright © 2019 Sam Reaves Digital. All rights reserved.
//

import UIKit

class ItemDetailViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item!
    
    /* Number formatter for value in dollars */
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    /* Date formatter for date created */
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    /* Just before view controller's view appears, load item information from ItemStore */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
    
    /* Just before view controller's view disappears, save user input to ItemStore */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* Save changes to item */
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    /* Just before return key on keyboard acts normally, have text field resign first responder */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
