//
//  MainVC-TextFieldDelegate.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-06.
//

import UIKit

extension MainViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true) // get rid of keyboard
        
        // guard to prevent player entering empty to create task
        guard let name = textField.text
        else { return false }
        
        // erase name on the list
        textField.text = ""

        addNewTask(name: name)
        return true
    }
    
    func addTask(name: String){
        Cloud.instance.saveTask(taskName: name)
    }
    
    func addNewTask (name: String)
    {
        // append new task name into Appdata's tasksList
        Appdata.shared.tasksList.append(name)
        
        // get the inserting index and insert with animation from left
        let myIndexPath = IndexPath(row: Appdata.shared.tasksList.count - 1,
                                    section: 0)
        
        taskListTableView.insertRows(at: [myIndexPath],
                                       with: UITableView.RowAnimation.left)
        // save to firebase
        Cloud.instance.saveTask(taskName: name)
    }
    
}
