//
//  loginVC.swift
//  Fetch
//
//  Created by Jonathan Tan on 3/22/16.
//  Copyright © 2016 Jonathan Tan. All rights reserved.
//

import UIKit
import QuartzCore
import Parse

class loginVC: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    
    // Constants
    let loginViewToRequest: String = "loginViewToRequest"
    
    // Outlets
    @IBOutlet weak var usernameLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!

    // Custom functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:  UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func DismissKeyboard() {
        view.endEditing(true)
    }
    
// Used for halfsize modal present
//    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
//        return HalfSizePresentationController(presentedViewController: presented, presentingViewController: presentingViewController!)
//    }
    
    // Actions
    @IBAction func registerDidTouch(sender: AnyObject) {
        // Attempt @ modal Present
//        var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var pvc = storyboard.instantiateViewControllerWithIdentifier("registerVC") as UIViewController
//        
//        pvc.modalPresentationStyle = UIModalPresentationStyle.Custom
//        pvc.transitioningDelegate = self
//        pvc.view.backgroundColor = UIColor.redColor()
//        
//        self.presentViewController(pvc, animated: true, completion: nil)

        self.performSegueWithIdentifier("loginToRegister", sender: self)
    }
    
    @IBAction func loginDidTouch(sender: AnyObject) {
        if usernameLoginTextField.text == "" || passwordLoginTextField.text == "" {
            self.displayAlert("Missing Field(s)", message: "All fields must be filled in.")
        }
        PFUser.logInWithUsernameInBackground(usernameLoginTextField.text!, password:passwordLoginTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("successfulLoginSegue", sender: self)
                print("Login Successful")
            } else {
                if let errorString = error?.userInfo["error"] as? NSString {
                    self.displayAlert("Login failed", message: errorString as String)
                }
            }
        }

    }
    
    // Overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.usernameLoginTextField.delegate = self;
        self.passwordLoginTextField.delegate = self;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let currentUser = PFUser.currentUser()
        if currentUser?.username != nil {
            performSegueWithIdentifier("successfulLoginSegue", sender: self)
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if (segue.identifier == "successfulLoginSegue") {
//            //get a reference to the destination view controller
//            let destinationVC:SWRevealViewController = segue.destinationViewController as! SWRevealViewController
//            destinationVC.activeUser = User()
//        }
//    }
    
}

//class HalfSizePresentationController : UIPresentationController {
//    override func frameOfPresentedViewInContainerView() -> CGRect {
//        return CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height/2)
//    }
//}
