////
////  LoginViewController.swift
////  Fetch
////
////  Created by Jonathan Tan on 3/21/16.
////  Copyright © 2016 Jonathan Tan. All rights reserved.
////
//
//import UIKit
//import QuartzCore
//import Firebase
//
//class LoginViewController: UIViewController, UITextFieldDelegate {
//    
//    // Constants
//    let ref = Firebase(url: "https://hyv3-fetch.firebaseio.com")
//    let loginViewToRequest: String = "loginViewToRequest"
//
//    // Outlets
//    @IBOutlet weak var textFieldLoginEmail: UITextField!
//    @IBOutlet weak var textFieldLoginPassword: UITextField!
//    
//    // Custom functions
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
//    
//    func displayAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle:  UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
//    
//    func DismissKeyboard() {
//        view.endEditing(true)
//    }
//    
//    // Actions
//    @IBAction func registerDidTouch(sender: AnyObject) {
//        self.performSegueWithIdentifier("loginToRegister", sender: self)
//    }
//    
//    @IBAction func loginDidTouch(sender: AnyObject) {
//        ref.authUser(textFieldLoginEmail.text, password: textFieldLoginPassword.text, withCompletionBlock: { (error, auth) -> Void in
//            
//        })
//    }
//    
//    // Overrided functions
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
//        view.addGestureRecognizer(tap)
//        
//        self.textFieldLoginEmail.delegate = self;
//        self.textFieldLoginPassword.delegate = self;
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        ref.observeAuthEventWithBlock { (authData) -> Void in
//            if authData != nil {
//                self.performSegueWithIdentifier(self.loginViewToRequest, sender: nil)
//            } else if authData == nil {
//                self.displayAlert("Error", message: "Invalid username or password.")
//            }
//            
//        }
//    }
//    
//}
//
