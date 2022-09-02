//
//  MainViewController.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-06.
//

import UIKit

import Firebase

class MainViewController: UIViewController {

    // textField for user to input new task name
    @IBOutlet weak var createTaskTextField: UITextField!
    @IBOutlet var taskListTableView: UITableView!
    
    @IBAction
    func signOutButton()
    {
        // dismiss to destroy the instantiated view controller
        self.dismiss(animated: true, completion: nil)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskListTableView.dataSource = self
        taskListTableView.delegate = self
        createTaskTextField.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
