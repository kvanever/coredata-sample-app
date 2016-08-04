//
//  ToDoListController.swift
//  CoreDataList
//
//  Created by Kevin VanEvery on 8/4/16.
//  Copyright © 2016 Kevin VanEvery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    lazy var fetchedResultsController: ToDoFetchedResultsController = {
       let controller = ToDoFetchedResultsController(managedObjectContext: self.managedObjectContext, withTableView: self.tableView)
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navgiation 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            guard let destinationController = segue.destinationViewController as? DetailViewController, indexPath = tableView.indexPathForSelectedRow else { return }
            
            let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Item
            destinationController.item = item
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        
        return section.numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath)
        
        return configureCell(cell, atIndexPath: indexPath)
    }
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexpath: NSIndexPath) -> UITableViewCell {
        let item = fetchedResultsController.objectAtIndexPath(indexpath) as! Item
        cell.textLabel?.text = item.text
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        
        managedObjectContext.deleteObject(item)
        DataController.sharedInstance.saveContext()
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }

}