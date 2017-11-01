//
//  SearchViewController.swift
//  StudySpace
//
//  Created by Omkar Waingankar on 10/28/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SearchViewController: UIViewController {

    var searchGroup : StudyGroup!
    
    @IBOutlet weak var tableView: UITableView!
    var groups = [StudyGroup]()
    var ref = FIRDatabase.database().reference(withPath: "groups")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        ref.observe(.value) { (snapshot) in
            print("FOUND NEW SNAPSHOT")
            self.groups = [StudyGroup]()
            for child in snapshot.children{
                if let child = child as? FIRDataSnapshot {
                    let group = StudyGroup(snapshot: child)
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        if !group.members.contains(uid) && group.course == self.searchGroup.course {
                            self.groups.append(group)
                            
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancel(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        cell.group = groups[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
        let ref = FIRDatabase.database().reference(withPath: "groups")
        ref.child(searchGroup.id!).removeValue()
        ref.child(group.id!).child("members").observeSingleEvent(of: .value) { (snap) in
            print(snap.value!)
            var snap = snap.value as? [String] ?? [String]()
            snap.append(FIRAuth.auth()?.currentUser?.uid ?? "NO ID")
            ref.child(group.id!).child("members").setValue(snap)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
        
    }
}
