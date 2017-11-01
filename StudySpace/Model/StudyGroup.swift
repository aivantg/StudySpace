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
    
    var members = [String]() //user objects
    var name : String?
    var course : String?
    var id : String?
    var prefLocation : String?
    var description : String?
    var memberLimit : Int?
    var searchDesc : String?
    var commonTimes : Schedule?
    var searching : Bool = false
    
    init(snapshot: FIRDataSnapshot){
        if let postDict = snapshot.value as? [String : AnyObject] {
            self.id = snapshot.key
            self.name = postDict["name"] as? String
            self.course = postDict["class"] as? String
            self.prefLocation = postDict["location"] as? String
            self.memberLimit = postDict["memberLimit"] as? Int
            self.description = postDict["desc"] as? String
            self.members = postDict["members"] as? [String] ?? [String]()
            self.searching = postDict["search"] as? Bool ?? false
        }
    }
    
    func getMemberString(callback: @escaping ((String) -> Void)){
        let ref = FIRDatabase.database().reference(withPath: "users")
        var result = ""
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for member in self.members {
                if let memSnapshot = snapshot.childSnapshot(forPath: member).value as? [String : AnyObject] {
                    result += (memSnapshot["name"] as? String) ?? "No Name"
                    result += ", "
                }
            }
            if result.last == " " {
                result = "\(result.dropLast().dropLast())"
            }
            callback(result)
        }
    }
    
}
