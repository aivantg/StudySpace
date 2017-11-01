//
//  SessionsTableViewCell.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/28/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SessionsTableViewCell: UITableViewCell {

    var session : StudySession?{
        didSet{
            if session != nil {
                updateView()
            }
        }
    }
    
    @IBOutlet weak var sessionImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var sessionDesc: UILabel!
    @IBOutlet weak var sessionCourse: UILabel!
    @IBOutlet weak var sessionReason: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateView(){
        if session!.location?.contains("Moffit") ?? false {
            self.sessionImage.image = #imageLiteral(resourceName: "moffit")
        }else if session!.location?.contains("MLK") ?? false {
            self.sessionImage.image = #imageLiteral(resourceName: "mlk")
        }else if session!.location?.contains("Doe") ?? false {
            self.sessionImage.image = #imageLiteral(resourceName: "doe_sunrise")
        }else {
            self.sessionImage.image = #imageLiteral(resourceName: "kresge")
        }

        self.locationLabel.text = self.session!.location
        self.sessionCourse.text = session!.course
        self.sessionDesc.text = session!.desc
        let ref = FIRDatabase.database().reference(withPath: "users/\(session!.user)")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let memSnapshot = snapshot.value as? [String : AnyObject]{
                self.sessionReason.text = " - \(memSnapshot["name"] as? String ?? "")"
            }
        }
    }
}
