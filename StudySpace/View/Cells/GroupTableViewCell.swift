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
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(){
        self.textLabel!.text = group!.name
        self.detailTextLabel!.text = group!.description
    }

}
