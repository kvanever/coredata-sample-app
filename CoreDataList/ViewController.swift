//
//  ViewController.swift
//  CoreDataList
//
//  Created by Kevin VanEvery on 8/4/16.
//  Copyright © 2016 Kevin VanEvery. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    let dataController = DataController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func save(sender: AnyObject) {
        
        guard let text = textField.text else { return }
        
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: dataController.managedObjectContext) as! Item
        
        item.text = text
        
        dataController.saveContext()
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
}

