////
////  RegisterViewController.swift
////  Fetch
////
////  Created by Jonathan Tan on 3/21/16.
////  Copyright © 2016 Jonathan Tan. All rights reserved.
////
//import UIKit
//import Foundation
//import Firebase
//
//class RegisterViewController: UIViewController, UITextFieldDelegate {
//    
//    // Constants
//    let ref = Firebase(url: "https://hyv3-fetch.firebaseio.com")
//    
//    // Outlets
//    @IBOutlet weak var fullNameTextField: UITextField!
//    @IBOutlet weak var emailAddressTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var confirmPasswordTextField: UITextField!
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
//    @IBAction func cancelDidTouch(sender: AnyObject) {
//        self.performSegueWithIdentifier("registerToLogin", sender: self)
//    }
//    
//    @IBAction func registerDidTouch(sender: AnyObject) {
//        if emailAddressTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" || fullNameTextField.text == "" {
//            displayAlert("Missing Field(s)", message: "All fields must be filled in.")
//        } else if passwordTextField.text != confirmPasswordTextField.text {
//                displayAlert("Error", message: "Confirm password must be identical to password.")
//        } else {
//            self.ref.createUser(self.emailAddressTextField.text, password: self.passwordTextField.text) { (error: NSError!) in
//                if error == nil {
//                    self.ref.authUser(self.emailAddressTextField.text, password: self.passwordTextField.text, withCompletionBlock: { (error, auth) in
//                    })
//                    self.performSegueWithIdentifier("registerToLogin", sender: self)
//                } else {
//                    self.displayAlert("Error", message: "Sorry your account could not be created at this time. Please make sure you are connected to the internet and try again later.")
//                }
//            }
//            
//        }
//    }
//    
//    // Overrided functions
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
//        view.addGestureRecognizer(tap)
//        
//        self.fullNameTextField.delegate = self;
//        self.emailAddressTextField.delegate = self;
//        self.passwordTextField.delegate = self;
//        self.confirmPasswordTextField.delegate = self;
//    }
//}