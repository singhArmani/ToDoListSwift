//
//  TaskTableViewController.swift
//  ToDoList
//
//  Created by simranjeet on 14/03/2016.
//  Copyright © 2016 singh. All rights reserved.
//

import UIKit
import Firebase

class TaskTableViewController: UITableViewController {
    
    //getting the firebase reference 
    var ref = Firebase(url: "https://todolistswift.firebaseio.com/")
    
    var tasks:[Task] = [Task]() // creating an empty array of task
    
    
    var userDefault = NSUserDefaults.standardUserDefaults() 


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let taskRef = ref.childByAppendingPath("Task-items") //getting the child node
        // 1
        taskRef.observeEventType(.Value, withBlock: { snapshot in
            
            // 2
            var newItems = [Task]()
            
            // 3
            for item in snapshot.children {
                
                print(snapshot)
                // 4
                let taskItem = Task(snapshot: item as! FDataSnapshot)
                newItems.append(taskItem)
            }
            
            // 5
            self.tasks = newItems
            self.tableView.reloadData()
        })
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Task", forIndexPath: indexPath)

        // Configure the cell...
         let taskItem = tasks[indexPath.row] as Task
            cell.textLabel?.text = taskItem.taskName
        if let isCompleted = taskItem.isCompleted {
            if(!isCompleted){
                cell.detailTextLabel?.text = "Not Completed"
            }
        }
            return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveTasks(segue:UIStoryboardSegue)
    {
        if let unwindFromMVC = segue.sourceViewController as? AddTaskViewController{
            
            let taskRef = ref.childByAppendingPath("Task-items")
            if let newTask = unwindFromMVC.task {
                tasks.append(newTask) //adding to our task list
                
                SaveToFirebase(newTask, ref: taskRef) //saving to firebase
                }
            
            if let newChore = unwindFromMVC.chores {
                let newTask2 = Task(name: newChore, date: NSDate(),completed: false)
                tasks.append(newTask2)
                
                SaveToFirebase(newTask2, ref: taskRef) //saving to firebase

            }
            tableView.reloadData()
        }
            
    }
    
    func SaveToFirebase(task:Task, ref:Firebase){
        let myTasks = task.toAnyObject()
        ref.childByAppendingPath(task.taskName).setValue(myTasks)
    }
    
    
    @IBAction func cancel(segue:UIStoryboardSegue){
        //it will exit 
    }
}
