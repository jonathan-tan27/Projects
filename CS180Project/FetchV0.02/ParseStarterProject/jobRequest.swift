//
//  jobDescriptionClass.swift
//  Fetch
//
//  Created by Jonathan Tan on 3/23/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import Parse

struct jobRequest {
    var addedByUser: String = ""
    var userFullName: String = ""
    var jobTitle: String = ""
    var jobCategory: String = ""
    var jobDescription: String = ""
    var jobAddress: String = ""
    var timeToComplete: Int = 0
    var activeRequest: Bool = false
    var completed: Bool = false
    
    // Initialize from arbitrary data
    init(name: String, addedByUser: String, title: String, category: String, description: String, address: String, timeLimit: Int, active: Bool, completed: Bool) {
        self.userFullName = name
        self.addedByUser = addedByUser
        self.jobTitle = title
        self.jobCategory = category
        self.jobAddress = address
        self.timeToComplete = timeLimit
        self.activeRequest = active
        self.completed = completed
    }

    init() {
        var requestedJob = PFObject(className: "RequestedJob")
        requestedJob["addedByUser"] = self.addedByUser
        requestedJob["userFullName"] = self.userFullName
        requestedJob["jobTitle"] = self.jobTitle
        requestedJob["jobCategory"] = self.jobCategory
        requestedJob["jobDescription"] = self.jobDescription
        requestedJob["jobAddress"] = self.jobAddress
        requestedJob["timeToComplete"] = self.timeToComplete
        requestedJob["activeRequest"] = self.activeRequest
        requestedJob["completed"] = self.completed
    }
    
    func showJobRequest() -> AnyObject {
        return [
            "Name": userFullName,
            "Username": addedByUser,
            "Title": jobTitle,
            "Category": jobCategory,
            "Address": jobAddress,
            "TimetoComplete": timeToComplete,
            "Active?": activeRequest,
            "Completed": completed
        ]
    }
}
//
//    
//    func showJobDescription() -> AnyObject {
//        return [
//            "Name": userFullName,
//            "Username": addedByUser,
//            "Job Title": jobTitle,
//            "Time Limit": timeToComplete,
//            "Category": jobCategory,
//            "Address": jobAddress,
//            "Description": jobDescription,
//            "completed": completed
//        ]
//    }
//    
//}