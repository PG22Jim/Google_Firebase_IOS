//
//  AppData.swift
//  MyFirebaseApp
//
//  Created by Jim Chen on 2022-08-06.
//

import Foundation
import UIKit


class Appdata
{
    private init () { }
    
    static let shared = Appdata ()
    
    var tasksList: Array<String> = ["1","2","3","4"]
}
