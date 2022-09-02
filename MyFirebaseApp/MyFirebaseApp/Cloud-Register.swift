//
//  Cloud-Register.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-16.
//

import Foundation

extension Cloud
{
    func Register(email: String, password: String, completion: @escaping (Bool, String)-> Void)
    {
        // create user with user inputed email and password
        myAuth.createUser(withEmail: email, password: password)
        {
            (authResult, error) in
            
            // guard to prevent further actions
            guard let user = authResult?.user,
                  error == nil else
            {
                if let err = error
                {
                    completion(false, err.localizedDescription)
                }
                return
            }
            
            completion(true, "User created with email: \(email)")
            
        }
    }
    
}
