//
//  MainVC-TableView.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-06.
//

import UIKit

extension MainViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        // if user is not deleting it, return
        if editingStyle != .delete
        {
            return
        }
        
        // if user wants to delete it, get the name
        let deletingTaskName = Appdata.shared.tasksList[indexPath.row]
        
        // Remove this first - VERY IMPORTANT
        // This will prevent tableView trying to fetch the deleted task from the list
        Appdata.shared.tasksList.remove(at: indexPath.row)

        tableView.deleteRows(at: [indexPath],
                             with: UITableView.RowAnimation.right)
        
        // Delete data from firebase
        Cloud.instance.deleteTask(deletingTask: deletingTaskName)
    }
}
