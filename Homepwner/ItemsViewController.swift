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
    
    /* Inform ItemsViewController's tableView how many items to display in the table */
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return itemStore.allItems.count
    }
    
    /* Inform ItemsViewController's tableView how each cell should appear */
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Get a reused or new instance of UITableViewCell with default appearance */
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)
        
        /*
         * Set the text on the cell with the description of the item
         * that is the nth index of the items, where n = row this cell
         * will appear on in the table view
         */
        let item = itemStore.allItems[indexPath.row]
 
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.valueInDollars)"
        
        return cell
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
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                
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
