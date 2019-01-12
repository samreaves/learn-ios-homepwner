//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Sam Reaves on 1/10/19.
//  Copyright © 2019 Sam Reaves Digital. All rights reserved.
//

import UIKit

class ItemsViewController : UITableViewController {
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton) {
        /* Create a new item and add it to the store */
        let newItem = itemStore.createItem()
        
        /* Figure out where that item is in the array */
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            /* Insert the new row into the table */
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        /* If currently in editing mode */
        if isEditing {
            
            /* Change the text to inform user of state */
            sender.setTitle("Edit", for: .normal)
            
            /* Turn off editing mode */
            setEditing(false, animated: true)
        }
        else {
            /* Change the text to inform user of state */
            sender.setTitle("Done", for: .normal)
            
            /* Turn on editing mode */
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    /* Inform ItemsViewController's tableView how many items to display in the table */
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return itemStore.allItems.count
    }
    
    /* Inform ItemsViewController's tableView how each cell should appear */
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Get a reused or new instance of UITableViewCell with default appearance */
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        
        /*
         * Set the text on the cell with the description of the item
         * that is the nth index of the items, where n = row this cell
         * will appear on in the table view
         */
        let item = itemStore.allItems[indexPath.row]
 
        cell.nameLabel.text = item.name
        cell.valueLabel.text = "\(getDollarAmount(item.valueInDollars))"
        cell.serialNumberLabel.text = item.serialNumber
        
        /* Adjust valueLabel font color to be red or green based on item value */
        cell.valueLabel.textColor = item.valueInDollars >= 50
            ? UIColor(red:0.00, green:0.81, blue:0.00, alpha:1.0)
            : UIColor.red
        
        return cell
    }
    
    /* Retrieves value in dollars for cell formatted with dollars and cents */
    func getDollarAmount(_ valueInDollars: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: valueInDollars))!
        
    }
    
     /* Inform ItemsViewController's tableView how to delete items */
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        /* If the table view is asking to commit a delete command */
        if editingStyle == .delete {
            
            /* Cache local copy of item */
            let item = itemStore.allItems[indexPath.row]
            
            /* Create action sheet to verify user meant to delete this potentially very important item */
            let areYouSureTitle = "Delete \(item.name)?"
            let areYouSureMessage = "Are you sure you want to delete this item?"
            let actionSheet = UIAlertController(title: areYouSureTitle,
                                                message: areYouSureMessage,
                                                preferredStyle: .actionSheet)
            
            /* Cancel action for action sheet */
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            /* Delete handler for action sheet */
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action) -> Void in
                
                /* Remove item from store */
                self.itemStore.removeItem(item)
                
                /* Delete the row from the table */
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            /* Add both handlers */
            actionSheet.addAction(cancelAction)
            actionSheet.addAction(deleteAction)
            
            /* Present the action sheet */
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    /* Inform ItemViewController's tableView how to move items */
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        
        /* Update the model */
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
