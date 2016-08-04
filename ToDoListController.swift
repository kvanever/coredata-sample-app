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
    
    lazy var dataSource: DataSource = {
        return DataSource(tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            guard let destinationController = segue.destinationViewController as? DetailViewController, indexPath = tableView.indexPathForSelectedRow else { return }
            
            let item = dataSource.objectAtIndexPath(indexPath) as! Item
            destinationController.item = item
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }

}