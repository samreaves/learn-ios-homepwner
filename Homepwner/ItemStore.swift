//
//  ItemStore.swift
//  Homepwner
//
//  Created by Sam Reaves on 1/10/19.
//  Copyright © 2019 Sam Reaves Digital. All rights reserved.
//

import UIKit

class ItemStore {
    
    /* Local cache of items */
    var allItems = [Item]()
    
    /* Creates random item and inserts into the store */
    @discardableResult func createItem() -> Item {
        let item = Item(random: true)
        
        allItems.append(item)
        
        return item
    }
    
    /* Removes item from the store */
    func removeItem(_ item: Item) -> Void {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    /* Moves item from one position in the store to another */
    func moveItem(from fromIndex: Int, to toIndex: Int) -> Void {
        
        /* If item has not moved positions, ignore */
        if fromIndex == toIndex {
            return
        }
        
        /* Cache moved item temporarily */
        let movedItem = allItems[fromIndex]
        
        /* Remove item from store */
        allItems.remove(at: fromIndex)
        
        /* Insert the item into its new location within the store */
        allItems.insert(movedItem, at: toIndex)
    }
}
