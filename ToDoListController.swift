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
    
    lazy var fetchRequest: NSFetchRequest = {
       let request = NSFetchRequest(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
       let controller = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try self.fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error fetching item objects: \(error.localizedDescription), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func  controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
}
