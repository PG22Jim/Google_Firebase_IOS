//
//  MainVC-TableDataSource.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-06.
//

import UIKit

extension MainViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return Appdata.shared.tasksList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // get the reusable cell from the tableView, which identifier is cellId
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        // create task into the table view by overwriting with task name
        cell?.textLabel?.text = Appdata.shared.tasksList[indexPath.row]
        
        return cell!
    }
}
