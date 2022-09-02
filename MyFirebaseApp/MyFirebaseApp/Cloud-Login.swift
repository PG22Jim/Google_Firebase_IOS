//
//  Cloud-Login.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-16.
//

import Foundation

extension Cloud
{
    // closure login with loginBool, fetchBool, and resultMessage
    func login(email: String, password: String, completion: @escaping (Bool, Bool, String) -> Void)
    {
        myAuth.signIn(withEmail: email, password: password)
        {
            (authResult, error) in

            // guard to return if user is nil or error comes out
            guard let user = authResult?.user,
                  error == nil else
            {
                if let err = error
                {
                    // if error comes out, return false results with error message
                    completion(false, false, err.localizedDescription)
                }
                return
            }
            
            // if sign in success, grab userID and fetch data from firebase
            let ID = self.getUserID()
            self.tryInitialize(userID: ID) { (res, message, fetchedList) in
                // if fetch result is success, overwrite currentList with fetched list
                if(res)
                {
                    // add ?? [] to have a default empty array to overwrite in case if fetchedList is nil
                    Appdata.shared.tasksList = fetchedList ?? []
                    // completion with loginSuccess, fetchSuccess, message
                    completion(true, true, message)
                }
                else
                {
                    completion(true, false, message)
                }
            }
        }
    }
    
    
    func getUserID() -> String
    {
        // guard to prevent currentUser is nil
        guard let currentUser = myAuth.currentUser else
        {
            print("Current User Doesn't Exist")
            return ""
        }
        return currentUser.uid
    }
    
    
    func tryInitialize(userID: String, completion: @escaping (Bool, String, [String]?) -> Void)
    {
        // observeSingle to get all the tasks in once and make it into a snapshot
        ref.child("users").child(userID).child("Tasks").observeSingleEvent(of: .value)
            {(snapshot) in
            // if lists has no task, no need to fetch, just return with completion false
            if !snapshot.hasChildren()
            {
                completion(false, "No Task To Be Fetched", [])
            }
            
            // set snapshot value to iterable array of dictionary
            let taskDic = snapshot.value as? [String:AnyObject]
            
            // empty new task list
            var newTaskList: Array<String> = []
            
            // for each dictionary in snapshot, grab the key, append into new list
            taskDic?.forEach
            { dic in
                let taskName = dic.key
                
                newTaskList.append(taskName)
            }
            
            // closure sorting to sort the list
            let sortList = newTaskList.sorted { (task1, task2) -> Bool in
                return task1 < task2
            }
            
            // if fetched list's count is same as snapshot childs, fetch success
            sortList.count
            if sortList.count == snapshot.childrenCount
            {
                // completion success with new fetched sorted list
                completion(true, "Successfully Fetched Data", sortList)
            }
            
            else
            {
                completion(false, "Failed To Fetch Data", [])
            }
        }
    }
    
    
    
}
