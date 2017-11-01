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

class NewGroupViewController: MainViewController {

    @IBOutlet weak var capacityText: UITextField!
    @IBOutlet weak var groupNameText: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var purposeButton: UIButton!
    @IBOutlet weak var frequencyButton: UIButton!
    @IBOutlet weak var numTimesButton: UIButton!
    @IBOutlet weak var courseButton: UIButton!
    
    var course: String = ""
    var location: String = ""
    var freqNum:String = "1"
    var freq : String = "Month"
    var purpose : String = "To Study"
    var name : String = ""
    
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
    
    lazy var freqNumDropdown : DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = self.numTimesButton
        dropDown.dataSource = ["1", "2", "3", "4"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.numTimesButton.setTitle(item, for: .normal)
            self.freqNum = item
        }

        return dropDown
    }()
    
    lazy var freqDropdown : DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = self.frequencyButton
        dropDown.dataSource = ["Week", "Month"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.frequencyButton.setTitle(item, for: .normal)
            self.freq = item
        }

        return dropDown
    }()
    
    lazy var courseDropdown : DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = self.courseButton
        dropDown.dataSource = ["CS61A", "Soc 1", "Math 54", "Amer 1", "Comp Lit 24", "MCB 32"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.courseButton.setTitle(item, for: .normal)
            self.course = item
        }

        return dropDown
    }()
    
    lazy var purposeDropdown : DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = self.purposeButton
        dropDown.dataSource = ["To Study", "To Prepare For Midterms", "To Work on Homework"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.purposeButton.setTitle(item, for: .normal)
            self.purpose = item
        }
        return dropDown
    }()
    
    enum Kind {
        case join
        case create
    }
    @IBAction func openLocation(_ sender: UIButton) {
        locationDropdown.show()
        self.view.endEditing(true)

    }
    
    @IBAction func openNumTimes(_ sender: UIButton) {
        freqNumDropdown.show()
        self.view.endEditing(true)


    }
    
    @IBAction func openFreq(_ sender: UIButton) {
        freqDropdown.show()
        self.view.endEditing(true)


    }
    
    @IBAction func openPurpose(_ sender: UIButton) {
        purposeDropdown.show()
        self.view.endEditing(true)


    }
    @IBAction func openCourse(_ sender: UIButton) {
        courseDropdown.show()
        self.view.endEditing(true)


    }
    
    @IBOutlet weak var createButton: UIButton!
    var type : Kind = .create
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func create() {
        if type == .create {
            name = groupNameText.text ?? ""
        }
        guard course != "" && location != "", freqNum != "", freq != "", purpose != "" else {
            let alert = UIAlertController(title: "Incomplete", message: "Make sure you fill out each field!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        let ref = FIRDatabase.database().reference(withPath: "groups").childByAutoId()

        if type == .join {
            ref.child("search").setValue(true)
            name = "Searching For Group"
        }else{
            if name == "" {
                let alert = UIAlertController(title: "Incomplete", message: "Make sure you fill out each field!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            ref.child("search").setValue(false)
        }
        ref.child("name").setValue(name)
        ref.child("location").setValue(location)
        ref.child("searchDesc").setValue(freqNum + " times a " + freq + " " + purpose)
        ref.child("class").setValue(course)
        ref.child("members").setValue([FIRAuth.auth()!.currentUser!.uid])
        self.view.endEditing(true)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

}
