//
//  Cloud.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-05.
//

import Foundation
import Firebase

class Cloud {
    // making Cloud class singleton, which only should be created in once
    static let instance = Cloud()
    
    var myAuth: Auth! // lateinit variable
    var ref: DatabaseReference!
    
    init() {
        // try to communicate GoogleService-info.plist
        FirebaseApp.configure()
        
        // short hand variables to be used
        myAuth = Auth.auth()
        ref = Database.database().reference()
    }
    
}
