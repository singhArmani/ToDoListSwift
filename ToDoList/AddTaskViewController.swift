//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by simranjeet on 14/03/2016.
//  Copyright © 2016 singh. All rights reserved.
//

import UIKit

class AddTaskViewController: UITableViewController {
    
    var task:Task?
    
    //when somebody selects 
    var chores:String? {
        didSet{
            choreLbl.text = chores
        }
    }
    
    @IBOutlet weak var TaskField: UITextField!
   
    @IBOutlet weak var choreLbl: UILabel!
        
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveSelection(segue:UIStoryboardSegue)
    {
        if let unWindFromMVC = segue.sourceViewController as? PickTaskViewController{
             self.chores = unWindFromMVC.selectedTask
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Save" {
            if TaskField.text != ""{
                task = Task(name: TaskField.text!, date: NSDate(), completed: false)
                
        }
    }
  }
}
