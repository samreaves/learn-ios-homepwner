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
    
    /* URL app calls to save and retreive data from sandbox */
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    /* Load items on init */
    init() {
        
        do {
            if let nsData = NSData(contentsOfFile: itemArchiveURL.path) {
                let data = Data(referencing:nsData)
                if let possibleObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item] {
                    allItems = possibleObject
                }
            }
        } catch {
            print("Could not load items from file")
        }
    }
    
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
    
    /* Save ItemStore to disk on close of the app */
    func saveChanges() -> Bool {
        print("Saving items to \(itemArchiveURL.path)")

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
            return true
        }
        catch {
            print("Couldn't save data")
            return false
        }
    }
}
