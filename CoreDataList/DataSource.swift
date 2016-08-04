//
//  DataSource.swift
//  CoreDataList
//
//  Created by Kevin VanEvery on 8/4/16.
//  Copyright © 2016 Kevin VanEvery. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataSource: NSObject, UITableViewDataSource {
    
    private let tableView: UITableView
    
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    lazy var fetchedResultsController: ToDoFetchedResultsController = {
        let controller = ToDoFetchedResultsController(managedObjectContext: self.managedObjectContext, withTableView: self.tableView)
        
        return controller
    }()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func objectAtIndexPath(indexPath: NSIndexPath) -> NSManagedObject {
        return fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        
        return section.numberOfObjects
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath)
        
        return configureCell(cell, atIndexPath: indexPath)
    }
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexpath: NSIndexPath) -> UITableViewCell {
        let item = fetchedResultsController.objectAtIndexPath(indexpath) as! Item
        cell.textLabel?.text = item.text
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        
        managedObjectContext.deleteObject(item)
        DataController.sharedInstance.saveContext()
    }
    
}

