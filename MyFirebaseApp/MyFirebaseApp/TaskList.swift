//
//  TaskList.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-06.
//

import Foundation
import Firebase

struct Task {
    var taskName: String
    
    func toDictionary() -> [String:Any] {
        return ["Task Name": self.taskName]
    }
}

extension Cloud{
    
    func saveTask(taskName: String){
        // guard to prevent currentUser is nil
        guard let currentUser = myAuth.currentUser else
        {
            print("Current User Doesn't Exist")
            return
            
        }
        // create new struct Task
        let newTask = Task(taskName: taskName)
        
        // make it a dictionary
        let objInDic = newTask.toDictionary()
        
        // getting the node / path
        let node = "/users/\(currentUser.uid)/Tasks/\(newTask.taskName)"
        
        // create an update with node and path
        let anUpdate = [node : objInDic]
        ref.updateChildValues(anUpdate)
    }
    
    func deleteTask(deletingTask: String){
        // guard to prevent currentUser is nil
        guard let currentUser = myAuth.currentUser else
        {
            print("Current User Doesn't Exist")
            return
        }
        
        // find the correct path and remove child value from it
        // since the value is empty, the parent(deletingTask) will get deleted automatically
        ref.child("users").child(currentUser.uid).child("Tasks").child(deletingTask).removeValue()
    }
    
}
