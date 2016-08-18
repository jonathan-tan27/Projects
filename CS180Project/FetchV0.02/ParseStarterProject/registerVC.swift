//
//  registerVC.swift
//  Fetch
//
//  Created by Jonathan Tan on 3/22/16.
//  Copyright © 2016 Jonathan Tan. All rights reserved.
//
import UIKit
import Foundation
import Parse

class registerVC: UIViewController, UITextFieldDelegate {
    
    // Constants
    var signUpState = true
    
    // Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    
    // Actions
    @IBAction func registerDidTouch(sender: AnyObject) {
        if usernameTextField.text == "" || emailAddressTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" || firstNameTextField.text == "" || lastNameTextField.text == "" {
            displayAlert("Missing Field(s)", message: "All fields must be filled in.")
        } else if passwordTextField.text != confirmPasswordTextField.text {
            displayAlert("Error", message: "Confirm password must be identical to password.")
        } else {
            var user = PFUser()
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            user.email = emailAddressTextField.text
            user["firstName"] = firstNameTextField.text
            user["lastName"] = lastNameTextField.text
            user["numActiveRequests"] = 0
            // other fields can be set just like with PFObject
            //user["phone"] = "415-392-0202"
            user.signUpInBackgroundWithBlock {
                (succeeded, error) -> Void in
                if let error = error {
                    if let errorString = error.userInfo["error"] as? NSString {
                        self.displayAlert("Registration failed", message: errorString as String)
                    }
                } else {
                    print("Successful registration")
                    self.performSegueWithIdentifier("registerToLogin", sender: self)
                }
            }
        }
    }
    
    @IBAction func cancelDidTouch(sender: AnyObject) {
        self.performSegueWithIdentifier("registerToLogin", sender: self)
    }
    
    // Overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.firstNameTextField.delegate = self;
        self.lastNameTextField.delegate = self;
        self.emailAddressTextField.delegate = self;
        self.passwordTextField.delegate = self;
        self.confirmPasswordTextField.delegate = self;
    }
}