//
//  StudySession.swift
//  StudySpace
//
//  Created by Omkar Waingankar on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import Foundation
import FirebaseDatabase

class StudySession {
    
    var group : StudyGroup?
    var members : [String]? //user objects
    var location : String?
    var desc : String?
    var approvalNeeded : Bool?
    var locationString : String?
    var course : String?
    var user : String = ""
    
    init(snapshot: FIRDataSnapshot){
        if let postDict = snapshot.value as? [String : AnyObject] {
            self.location = postDict["location"] as? String
            self.desc = postDict["desc"] as? String
            self.course = postDict["course"] as? String
            self.user = postDict["user"] as? String ?? ""
        }
    }
}
