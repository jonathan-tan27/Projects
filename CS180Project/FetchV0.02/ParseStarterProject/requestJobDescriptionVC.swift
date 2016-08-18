//
//  requestSearchVC.swift
//  Fetch
//
//  Created by Jonathan Tan on 3/23/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import Parse

class requestJobDescriptionVC: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //
    // Constants
    //
    let PLACEHOLDER_TEXT = "Enter the job description here!\nMax characters = 500"
    var categoryArray = ["Groceries","Food","Drinks","Transportation","Line/Waiting Service","Baby Sitting","Special Request"]
    var hourLimitArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    var minutesLimitArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"]
    var dayLimitArray = ["0","1","2","3","4","5","6","7"]
    var categoryChoice = 0
    var dayChoice:Int = 0
    var hourChoice:Int = 0
    var minuteChoice:Int = 0
    let limitLength = 500
    var activeRequest = false
    var currentAddress: String?
    var activeUser: User!
    var currentUser = PFUser.currentUser()
    // Add timer constant for num seconds
    //var Count = Int()
    
    //
    // Outlets
    //
    @IBOutlet weak var jobCategoryPicker: UIPickerView!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var jobAddress: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var daysPicker: UIPickerView!
    @IBOutlet weak var daysTextField: UITextField!
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var minutesPicker: UIPickerView!
    @IBOutlet weak var minutesTextField: UITextField!
    // Add timer outlet for timer countdown
    // @IBOutlet var countDownLabel: UILabel!
    
    //**
    // Custom functions
    //**
    
    //*
    // displayAlert
    //*
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:  UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //*
    // Create placeholder text within textView
    //*
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = PLACEHOLDER_TEXT
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
    
    //*
    // Create categoryPickerView
    //*
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == jobCategoryPicker {
            return categoryArray[row]
        } else if pickerView == daysPicker {
            return dayLimitArray[row]
        } else if pickerView == hoursPicker {
            return hourLimitArray[row]
        } else {
            return minutesLimitArray[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == jobCategoryPicker {
            return categoryArray.count
        } else if pickerView == daysPicker {
            return dayLimitArray.count
        } else if pickerView == hoursPicker {
            return hourLimitArray.count
        } else {
            return minutesLimitArray.count
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == jobCategoryPicker {
            jobCategoryPicker.hidden = true
            categoryTextField.text = categoryArray[row]
        } else if pickerView == daysPicker {
            daysPicker.hidden = true
            daysTextField.text = dayLimitArray[row]
            dayChoice = Int(dayLimitArray[row])!
        } else if pickerView == hoursPicker {
            hoursPicker.hidden = true
            hoursTextField.text = hourLimitArray[row]
            hourChoice = Int(hourLimitArray[row])!
        } else {
            minutesPicker.hidden = true
            minutesTextField.text = minutesLimitArray[row]
            minuteChoice = Int(minutesLimitArray[row])!
        }
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == categoryTextField {
            categoryTextField.text = ""
            jobCategoryPicker.hidden = false
        } else if textField == daysTextField {
            daysTextField.text = ""
            daysPicker.hidden = false
        } else if textField == hoursTextField {
            hoursTextField.text = ""
            hoursPicker.hidden = false
        } else {
            minutesTextField.text = ""
            minutesPicker.hidden = false
        }
        return false
    }
    //
    // Count down timer
    //
//    func update() {
//        if(count > 0) {
//            countDownLabel.text = String(count--)
//        }
//    }
    
    //
    // Actions
    //
    @IBAction func fetchDidTouch(sender: AnyObject) {
        if currentUser != nil {
            var tempNum = self.currentUser!["numActiveRequests"] as! Int
            
            if tempNum <= 10 {
                let firstName = currentUser!["firstName"] as! String
                let lastName = currentUser!["lastName"] as! String
                let fullName = firstName + " " + lastName as! String
                let totalTime = (dayChoice*24*60 + hourChoice*60 + minuteChoice) as Int
                let request = PFObject(className: "jobRequest")
                request["user"] = PFUser.currentUser()
                request["fullName"] = fullName
                request["jobTitle"] = jobTitle.text
                request["jobCategory"] = categoryTextField.text
                request["jobDescription"] = descriptionTextView.text
                request["jobAddress"] = jobAddress.text
                request["totalTimeForCompletion"] = totalTime
                request["active"] = true
                request["completed"] = false
                request["jobEmployee"] = ""
                
                // Create alert controller to obtain $ offer
                var alert = UIAlertController(title: "Tip for Completion", message: "How much will you pay for completion of this task? (This is for the other party and does not include fees for items acquired in the task).", preferredStyle: .Alert)
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    textField.placeholder = "Example: $10"
                })
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    let textField = alert.textFields![0] as UITextField
                    print("Text field: \(textField.text)")
                    request["jobPayment"] = textField.text
                    request.saveInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
                        if (success) {
                            tempNum += 1
                            self.currentUser!["numActiveRequests"] = tempNum
                            print("Request successfully saved to Parse db.\n")
                            print("Total active requests: ")
                            print(tempNum)
                            print("daysChoice")
                            print(self.dayChoice)
                            print("hourChoice")
                            print(self.hourChoice)
                            print("minuteChoice")
                            print(self.minuteChoice)
                            print("Total Time")
                            print(totalTime)
                            self.performSegueWithIdentifier("requestSavedSuccessfullySegue", sender: self)
                        } else {
                            self.displayAlert("Request could not be saved", message: "Please try again later.")
                            print("Error: Request did not save.\n")
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
                    alert.dismissViewControllerAnimated(false, completion: nil)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                self.displayAlert("Maximum Fetch Requests reached (10)", message: "You may only have 10 active requests at a time.")
            }
        } else { // currentUser == nil
            print("Error: Current user is not verified.\n")
        }
    }
    
    @IBAction func cancelDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("cancelMenuRequestSegue", sender: self)
    }
    
    //
    // Overrided Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial job address to currentAddress
        jobAddress.text = activeUser.currentLocation
        
        // Setup Time Limit selection
        jobCategoryPicker.hidden = true
        daysPicker.hidden = true
        hoursPicker.hidden = true
        minutesPicker.hidden = true
        
        categoryTextField.text = categoryArray[0]
        daysTextField.text = dayLimitArray[0]
        hoursTextField.text = hourLimitArray[0]
        minutesTextField.text = minutesLimitArray[0]
        
        jobCategoryPicker.delegate = self
        daysPicker.delegate = self
        hoursPicker.delegate = self
        minutesPicker.delegate = self
        
        categoryTextField.delegate = self
        daysTextField.delegate = self
        hoursTextField.delegate = self
        minutesTextField.delegate = self
        
        // Add placeholder to textView
        descriptionTextView.text = PLACEHOLDER_TEXT
        descriptionTextView.textColor = UIColor.lightGrayColor()
        descriptionTextView.delegate = self
        
        // un-comment for Timer
        // var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }

}
