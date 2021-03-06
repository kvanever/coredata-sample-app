//
//  CoreDataStack.swift
//  CoreDataList
//
//  Created by Kevin VanEvery on 8/4/16.
//  Copyright © 2016 Kevin VanEvery. All rights reserved.
//

import Foundation
import CoreData

public class DataController: NSObject {
    
    static let sharedInstance = DataController()
    
    private override init() {}
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        
       let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex.predecessor()]
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
       let modelURL = NSBundle.mainBundle().URLForResource("ToDoList", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinater: NSPersistentStoreCoordinator = {
       let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("ToDoList.sqlite")
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            let userInfo: [String: AnyObject] = [
                NSLocalizedDescriptionKey: "Failed to initialize the application's saved data",
                NSLocalizedFailureReasonErrorKey: "There was an error creating or loading the application's saved data",
                NSUnderlyingErrorKey: error as NSError
            ]
            
            let wrappedError = NSError(domain: "com.kevinvanevery.CoreDataError", code: 9999, userInfo: userInfo)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    public lazy var managedObjectContext: NSManagedObjectContext = {
       let coordinator = self.persistentStoreCoordinater
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
    }()
    
    public func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }




























}