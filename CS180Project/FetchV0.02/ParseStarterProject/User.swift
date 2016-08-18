//
//  LoginViewController.swift
//  Fetch
//
//  Created by Jonathan Tan on 3/21/16.
//  Copyright © 2016 Jonathan Tan. All rights reserved.
//

import Foundation
import Parse

struct User {
    var username: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var fullName: String = ""
    var emailAddress: String = ""
    var currentLocation: String = ""
    var totalActiveRequests: Int = 0
    let currentUser = PFUser.currentUser()
    
    
    init() {
        if currentUser?.username != nil {
            self.username = currentUser!["username"] as! String
            self.firstName = currentUser!["firstName"] as! String
            self.lastName = currentUser!["lastName"] as! String
            self.fullName = self.firstName + " " + self.lastName
            self.emailAddress = currentUser!["email"] as! String
            self.totalActiveRequests = 0
            self.currentLocation = ""
        }
    }
    
}