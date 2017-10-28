//
//  StudyGroup.swift
//  StudySpace
//
//  Created by Omkar Waingankar on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import Foundation
import FirebaseDatabase

class StudyGroup {
    
    var members : [String]? //user objects
    var name : String?
    var course : String?
    var prefLocation : String?
    var description : String?
    var memberLimit : Int?
    var searchDesc : String?
    var commonTimes : Schedule?
    
    init(snapshot: FIRDataSnapshot){
        if let postDict = snapshot.value as? [String : AnyObject] {
            self.name = postDict["name"] as? String
            self.course = postDict["class"] as? String
            self.prefLocation = postDict["location"] as? String
            self.memberLimit = postDict["memberLimit"] as? Int
            self.description = postDict["desc"] as? String
        }
    }
    
}
