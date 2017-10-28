//
//  SessionsViewController.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SessionsViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView!
    var sessions = [StudySession]()
    var ref = FIRDatabase.database().reference(withPath: "sessions")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { (snapshot) in
            print("FOUND NEW SNAPSHOT")
            self.sessions = [StudySession]()
            for child in snapshot.children{
                if let child = child as? FIRDataSnapshot {
                    self.sessions.append(StudySession(snapshot: child))
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

extension SessionsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! SessionsTableViewCell
        cell.session = sessions[indexPath.row]
        return cell
    }
}
