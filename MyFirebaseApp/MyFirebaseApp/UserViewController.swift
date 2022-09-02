//
//  ViewController.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-05.
//

import UIKit

import Firebase

class UserViewController: UIViewController {

    // HardcodedUserName and password
    let hardcodeUserName: String = "PG22test@vfs.com"
    let hardcodePassword: String = "s1314570"
    
    // text fields
    @IBOutlet weak var taskTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    // save and load buttons
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    
    @IBAction
    func loginButton(){
        // guard to prevent getting empty email or password
        guard let email = emailTxtField.text,
              let password = passwordTxtField.text else { return }

        // calls cloud closure login
        Cloud.instance.login(email: email, password: password) { (loginResult, fetchResult, message) in
            
            // if login fails, prevent login and fetch data
            if(!loginResult)
            {
                let title = "Login Failed"
                self.alertMessage(title: title, message: message)
                return
            }
            

            // successful login
            self.login()
        }
    }
    
    @IBAction
    func registerButton(){
        // guard to prevent getting empty email or password
        guard let email = emailTxtField.text,
              let password = passwordTxtField.text else { return }
        
        // calls the register and login functions from Cloud singleton
        Cloud.instance.Register(email: email, password: password) { (regResult, message) in
            if(regResult)
            {
                // if register success, login
                Cloud.instance.login(email: email, password: password) { (loginResult, fetchResult, message) in
                    self.login()
                }
            }
            else
            {
                // alert message pops up when user failed to register
                let dialog = UIAlertController(title:"Register Failed", message:message, preferredStyle: .alert)
                
                // make a action button to add into alert dialog
                let action = UIAlertAction(title:"OK", style: .default, handler: {(alert:UIAlertAction!)-> Void in
                })
                dialog.addAction(action)
                self.present(dialog, animated:true, completion:nil)
            }
            
        }
    }
    
    func login()
    {
        // use storyboard identifier to set up MainVC as the instantiateViewController
        let controller = storyboard?.instantiateViewController(identifier: "MainVC") as! MainViewController
        // set the main view controller presentation to full screen
        controller.modalPresentationStyle = .fullScreen
        
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // making input password not visible
        passwordTxtField.isSecureTextEntry = true
    }
    
    
    func alertMessage(title: String, message: String)
    {
        // making dialog of alert message
        let dialog = UIAlertController(title:title, message:message, preferredStyle: .alert)
        
        // make a action button to add into alert dialog
        let action = UIAlertAction(title:"OK", style: .default, handler: {(alert:UIAlertAction!)-> Void in
        })
        dialog.addAction(action)
        self.present(dialog, animated:true, completion:nil)
    }
    

}

