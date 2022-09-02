//
//  Cloud-ExtensionFunc.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-16.
//

import Foundation


// opening a channel, continouslly obeserve value changes
extension Cloud{

    func readContinually(){
        let userID = getUserID()
        
        // grab the user's path and snapshot the value
        ref.child("user").child(userID).child("username").observe(.value) { (snapshot) in
            print("Found")
            // dump all the valuse from single snapshot
            dump(snapshot.value)
        }
    }
    
    func writeNestedValues(){
        let userID = getUserID()
        
        ref.child("users/\(userID)/AnotherThing").setValue("YES")
        
    }
    
    func writeUserName()
    {
        let userID = getUserID()
        
        ref.child("users").child(userID).setValue(["username" : "JimChen"])
    }
    
    func readUserValue()
    {
        let userID = getUserID()
        
        ref.child("users").child(userID).child("Tasks").observeSingleEvent(of: .value) {(snapshot) in
            // read all snapshot value as NSDictionary and dump all of it
            let value = snapshot.value as? NSDictionary
            dump(value)
        }
    }
}
