//
//  UserTableViewCell.swift
//  StudySpace
//
//  Created by Omkar Waingankar on 10/28/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    var user : User!{
        didSet{
            if user != nil {
                updateView()
            }
        }
    }

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    func updateView(){
        courseLabel.text = user.courses
        yearLabel.text = "Class of \(user.year ?? "2021")"
        nameLabel.text = user.username
        if user.username.contains("Ken"){
            self.userImage.image = #imageLiteral(resourceName: "ken")
        }else if user.username.contains("Rachel") {
            self.userImage.image = #imageLiteral(resourceName: "rachel")
        }else if user.username.contains("Luke") {
            self.userImage.image = #imageLiteral(resourceName: "luke")
        }else if user.username.contains("Soroush"){
            self.userImage.image = #imageLiteral(resourceName: "soroush")
        }else if user.username.contains("Keith"){
            self.userImage.image = #imageLiteral(resourceName: "keith")
        }else {
            self.userImage.image = #imageLiteral(resourceName: "bernie")
        }
    }

}
