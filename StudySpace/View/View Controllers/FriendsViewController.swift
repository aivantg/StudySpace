//
//  FriendsViewController.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FriendsViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView!
    var ref = FIRDatabase.database().reference(withPath: "users")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    var users = [User]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { (snapshot) in
            print("FOUND NEW SNAPSHOT")
            self.users = [User]()
            for child in snapshot.children{
                if let child = child as? FIRDataSnapshot {
                    let user = User(snapshot: child)
                    self.users.append(user)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    
}

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


