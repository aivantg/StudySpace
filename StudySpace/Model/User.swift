//
//  File.swift
//  StudySpace
//
//  Created by Omkar Waingankar on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import Foundation
import FirebaseDatabase

class User{
    
    var profPic : String?
    var classes : [String]? //class objects
    var username : String = ""
    var email : String?
    var phoneNumber : String?
    var password : String?
    var prefLocation : Location?
    var schedule : Schedule?
    var year : String?
    var major : String?
    var courses : String?
    var friends : [String]? //user objects
    var groups : [String]? //study group objects
    
    init(snapshot: FIRDataSnapshot) {
        if let postDict = snapshot.value as? [String : AnyObject] {
            self.username = postDict["name"] as? String ?? ""
            self.courses = postDict["classes"] as? String
            self.year = postDict["year"] as? String
        }
    }
    
}
