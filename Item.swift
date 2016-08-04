//
//  Item.swift
//  CoreDataList
//
//  Created by Kevin VanEvery on 8/4/16.
//  Copyright © 2016 Kevin VanEvery. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {
    
    static let identifier = "Item"

    static let fetchRequest: NSFetchRequest = {
        let request = NSFetchRequest(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }()

}
