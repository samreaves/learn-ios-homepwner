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
}
