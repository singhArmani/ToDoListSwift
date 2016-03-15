//
//  PickTaskViewController.swift
//  ToDoList
//
//  Created by simranjeet on 15/03/2016.
//  Copyright © 2016 singh. All rights reserved.
//

import UIKit



class PickTaskViewController: UITableViewController {
  
    
    
    var inBuiltTaskList:[String] = ["Buy Bananas", "Get Milk", "Get Eggs"]
    
    //lets create a computed property 
    var selectedTask:String? {
        didSet{
            if let task = selectedTask{
                selectedTaskIndex = inBuiltTaskList.indexOf(task) //updating the selectedTaskIndex here
            }
        }
    }
    
    
    var selectedTaskIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    //MARK: - Table Row Selection 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //setting the selected task
        selectedTask = inBuiltTaskList[indexPath.row] // it will update the selectedTaskIndex too 
        let cell = tableView.cellForRowAtIndexPath(indexPath) //getting that cell for changing it's accesories
          cell?.accessoryType = .Checkmark
        }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //getting that cell 
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .None
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return inBuiltTaskList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskList", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = inBuiltTaskList[indexPath.row]
        //print("cell created")
        return cell
    
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChorePicker" {
            if let chorecell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(chorecell)
                if let index = indexPath?.row{
                    selectedTask = inBuiltTaskList[index]
                }
           }
        }
    }
    

}
