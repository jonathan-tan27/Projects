//
//  randomVC.swift
//  Fetch
//
//  Created by Jonathan Tan on 5/2/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class randomVC: UIViewController {
 
    var currentUser = PFUser.currentUser()
    @IBOutlet weak var randomText: UITextField!
    
    @IBAction func buttonDidTouch(sender: AnyObject) {
        if(randomText.text?.characters.count > 0) {
        if currentUser != nil {
                print("touched")
                let firstName = currentUser!["firstName"] as! String
                let lastName = currentUser!["lastName"] as! String
                let fullName = firstName + " " + lastName as! String
                let request = PFObject(className: "test")
                request["user"] = PFUser.currentUser()
                request["fullName"] = fullName
                request["randomText"] = randomText.text
                request["active"] = true
                request["completed"] = false
                request["jobEmployee"] = ""
                request.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("saved")
                } else {
                    // There was a problem, check error.description
                    print("error")
                }
            }
                
        } else { // currentUser == nil
            print("Error: Current user is not verified.\n")
        }
        } else {
            print("not enough char")
        }
    }
    
    
}
