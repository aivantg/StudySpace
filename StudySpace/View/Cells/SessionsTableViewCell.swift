//
//  SessionsTableViewCell.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/28/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit

class SessionsTableViewCell: UITableViewCell {

    var session : StudySession?{
        didSet{
            if session != nil {
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
        self.textLabel!.text = session!.location
        self.detailTextLabel!.text = session!.desc
    }
}
