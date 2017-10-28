//
//  HomeViewController.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeViewController: MainViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.dataSource = self
        var ref = FIRDatabase.database().reference()
        var courseRef = ref.child("courses").childByAutoId()
        courseRef.child("name").setValue("CS 61A")
        courseRef.child("id").setValue("CS61A 001")
        courseRef.child("professor").setValue("John Denero")
        
        courseRef = ref.child("courses").childByAutoId()
        courseRef.child("name").setValue("CS 61B")
        courseRef.child("id").setValue("CS61B 001")
        courseRef.child("professor").setValue("Paul Hilfinger")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//
//extension HomeViewController: UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//}

