//
//  SessionsViewController.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Presentr

class SessionsViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView!
    var sessions = [StudySession]()
    var ref = FIRDatabase.database().reference(withPath: "sessions")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    var presentr : Presentr?
    @IBAction func newSession(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateSessionViewController") as! NewSessionViewController
        self.presentr = Presentr(presentationType: .bottomHalf)
        self.customPresentViewController(self.presentr!, viewController: vc, animated: true, completion: nil)
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

extension SessionsViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionsTableViewCell
        cell.session = sessions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
