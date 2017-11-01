//
//  NewGroupViewController.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import DropDown
import FirebaseDatabase
import FirebaseAuth

class NewSessionViewController: MainViewController {
    
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var locationButton: UIButton!

    @IBOutlet weak var courseButton: UIButton!
    
    var course: String = ""
    var location: String = ""
    var desc : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if course != "" {
            courseButton.titleLabel?.text = course 
        }
    }
    
    lazy var locationDropdown : DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = self.locationButton
        dropDown.dataSource = ["Moffit Library", "Kresge Library", "MLK Student Union", "Doe Library"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.locationButton.setTitle(item, for: .normal)
            self.location = item
        }
        
        return dropDown
    }()
    
    lazy var courseDropdown : DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = self.courseButton
        dropDown.dataSource = ["CS61A", "CS189" , "Soc 1", "Math 54", "Amer 1", "Comp Lit 24", "MCB 32"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.courseButton.setTitle(item, for: .normal)
            self.course = item
        }
        
        return dropDown
    }()

    @IBAction func openLocation(_ sender: UIButton) {
        locationDropdown.show()
        self.view.endEditing(true)
        
    }
    
    @IBAction func openCourse(_ sender: UIButton) {
        courseDropdown.show()
        self.view.endEditing(true)
        
        
    }
    
    @IBAction func create() {
        desc = descText.text ?? ""
        guard course != "" && location != "" && desc != "" else {
            let alert = UIAlertController(title: "Incomplete", message: "Make sure you fill out each field!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        let ref = FIRDatabase.database().reference(withPath: "sessions").childByAutoId()
        ref.child("location").setValue(location)
        ref.child("course").setValue(course)
        ref.child("desc").setValue(desc)
        ref.child("user").setValue(FIRAuth.auth()?.currentUser?.uid ?? "No ID")
        self.view.endEditing(true)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}

