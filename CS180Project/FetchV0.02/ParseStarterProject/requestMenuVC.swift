//
//  requestMenuVC.swift
//  Fetch
//
//  Created by Jonathan Tan on 3/22/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit

class requestMenuVC: UIViewController, UIPopoverPresentationControllerDelegate {
    // *
    // Constants
    // *
    var activeUser: User!
    var currentAddress: String!
    
    // *
    // Custom functions
    // *
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    // *
    // Actions
    // *
    @IBAction func returnDidTouch(sender: AnyObject) {
        self.performSegueWithIdentifier("returnFromMenuSegue", sender: self)
    }
    
    @IBAction func specialRequestDidTouch(sender: AnyObject) {
        self.performSegueWithIdentifier("menuToSpecialRequestSegue", sender: self)
    }
    
    // *
    // Overrided Functions
    // *
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "menuToSpecialRequestSegue") {
            var destinationVC = segue.destinationViewController as! requestJobDescriptionVC
            destinationVC.activeUser = activeUser
            destinationVC.currentAddress = currentAddress
        }
        if (segue.identifier == "returnFromMenuSegue") {
        }
    }

    

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "menuToSpecialRequestSegue" {
//            var vc = segue.destinationViewController as! requestSearchVC
//            vc.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width-15, height: UIScreen.mainScreen().bounds.height-15)
//            var controller = vc.popoverPresentationController
//            if controller != nil {
//                controller?.delegate = self
//                returnFromPopover.hidden = false
//            }
//        }
//    }
    
    
}