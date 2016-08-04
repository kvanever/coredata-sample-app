//
//  Item+CoreDataProperties.swift
//  CoreDataList
//
//  Created by Kevin VanEvery on 8/4/16.
//  Copyright © 2016 Kevin VanEvery. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var completed: Bool
    @NSManaged var text: String?

}
