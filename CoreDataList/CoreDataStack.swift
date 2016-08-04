//
//  CoreDataStack.swift
//  CoreDataList
//
//  Created by Kevin VanEvery on 8/4/16.
//  Copyright © 2016 Kevin VanEvery. All rights reserved.
//

import Foundation

class DataController: NSObject {
    
    lazy var applicationDocumentsDirectory: NSURL = {
        
       let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex.predecessor()]
    }()
}