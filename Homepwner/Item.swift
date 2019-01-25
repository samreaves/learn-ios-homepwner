//
//  Item.swift
//  Homepwner
//
//  Created by Sam Reaves on 1/10/19.
//  Copyright © 2019 Sam Reaves Digital. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    // MARK: - Properties
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    let itemKey: String
    
    // MARK: - Initializers
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
    }
    
    required init(coder aCoder: NSCoder) {
        name = aCoder.decodeObject(forKey: "name") as! String
        valueInDollars = aCoder.decodeInteger(forKey: "valueInDollars")
        serialNumber = aCoder.decodeObject(forKey: "serialNumber") as! String?
        itemKey = aCoder.decodeObject(forKey: "itemKey") as! String
        dateCreated = aCoder.decodeObject(forKey: "dateCreated") as! Date
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if (random) {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var index = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(index)]
            
            index = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(index)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        }
        else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    // MARK: - Encoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(itemKey, forKey: "itemKey")
        aCoder.encode(dateCreated, forKey: "dateCreated")
    }
}
