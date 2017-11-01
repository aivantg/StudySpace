//
//  GroupTableViewCell.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/28/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    var group : StudyGroup?{
        didSet{
            if group != nil {
                updateView()
            }
        }
    }
    var index : Int = 0
    
    
    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupMembers: UILabel!
    @IBOutlet weak var groupClass: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(){
        if group!.course?.contains("CS") ?? false{
            self.groupImage.image = #imageLiteral(resourceName: "terminal")
        }else if group!.course?.contains("Math") ?? false {
            self.groupImage.image = #imageLiteral(resourceName: "math")
        }else if group!.course?.contains("Soc") ?? false {
            self.groupImage.image = #imageLiteral(resourceName: "books")
        }else {
            self.groupImage.image = #imageLiteral(resourceName: "innovate")
        }
        self.groupTitle.text = group!.name
        self.groupClass.text = group!.course
        if group!.searching {
            self.dashLabel.isHidden = true
            self.groupMembers.isHidden = true
            self.groupTitle.textColor = UIColor.orange
            self.membersLabel.text = "Tap to find a group"
        }else{
            self.groupTitle.textColor = UIColor.black
            self.membersLabel.text = "Members"
            group!.getMemberString { (string) in
                self.groupMembers.text = string
            }
            self.dashLabel.isHidden = false
            self.groupMembers.isHidden = false
        }
    }

}
