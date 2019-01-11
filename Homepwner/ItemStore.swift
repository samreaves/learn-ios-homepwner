//
//  ItemStore.swift
//  Homepwner
//
//  Created by Sam Reaves on 1/10/19.
//  Copyright © 2019 Sam Reaves Digital. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        let item = Item(random: true)
        
        allItems.append(item)
        
        return item
    }
}
