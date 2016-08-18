//
//  backTableViewController.swift
//  Fetch
//
//  Created by Jonathan Tan on 3/21/16.
//  Copyright © 2016 Jonathan Tan. All rights reserved.
//

import Foundation
import UIKit
import Parse

class backTableViewController: UITableViewController {
    
    var tableArray = [String]()
    
    override func viewDidLoad() {
        tableArray = ["Pending","Completed","Help","Promotions","Account","Settings","Log Out"]
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.tag = indexPath.row
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0) {
            // Do Pending
        } else if (indexPath.row == 1) {
            // Do Completed
        } else if (indexPath.row == 2) {
            // Open help page
        } else if (indexPath.row == 3) {
            // Enter promotional values
        } else if (indexPath.row == 4) {
            // Open account view controller
        } else if (indexPath.row == 5) {
            // Open settings
        } else if (indexPath.row == 6) {
            // Log Out
            PFUser.logOut()
            let currentUser = PFUser.currentUser()
            print(currentUser)
            print("\nLogout Successful\n")
            self.performSegueWithIdentifier("successfulLogoutSegue", sender: self)
        }
    }
}