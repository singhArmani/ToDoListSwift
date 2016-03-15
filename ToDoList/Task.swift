//
//  Task.swift
//  ToDoList
//
//  Created by simranjeet on 14/03/2016.
//  Copyright © 2016 singh. All rights reserved.
//

import Foundation
import Firebase


//defining what a task would be 
 struct Task
{
    var taskName:String?
    var DateCreated:NSDate?
    var taskPriority:Priority?
    var isCompleted:Bool? = false
    var ref:Firebase?
    
    //we need to configure DateExpired so, I used lazy initialiser
    lazy var DateExpired:NSDate = {
        let lazyilyCreatedDate = NSDate(timeInterval: 24*60*60, sinceDate: self.DateCreated!)
        return lazyilyCreatedDate
    }()
    
    
  //add priority later
    
    init(name:String, date:NSDate, completed:Bool){
        self.taskName = name
        self.DateCreated = date
        self.isCompleted = completed
    }
    
    init(snapshot:FDataSnapshot)
    {
        self.taskName = snapshot.value["name"] as? String
        self.isCompleted = snapshot.value["isCompleted"] as? Bool
    }
    
    func toAnyObject() -> AnyObject {
        var myDictionary = Dictionary<String, AnyObject>()
        myDictionary["name"] = taskName
        myDictionary["isCompleted"] = isCompleted
        return myDictionary
        }
}

enum Priority:String {
    case High
    case Medium
    case Low
}