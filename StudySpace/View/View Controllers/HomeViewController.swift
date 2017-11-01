//
//  HomeViewController.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Presentr

class HomeViewController: MainViewController {
    
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
        ref.observe(.value) { (snapshot) in
            print("FOUND NEW SNAPSHOT")
            self.groups = [StudyGroup]()
            for child in snapshot.children{
                if let child = child as? FIRDataSnapshot {
                    let group = StudyGroup(snapshot: child)
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        if group.members.contains(uid){
                            self.groups.append(group)

                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
        let secref = FIRDatabase.database().reference(withPath: "users/\(FIRAuth.auth()?.currentUser?.uid ?? "NO ID")")
        secref.observeSingleEvent(of: .value) { (snapshot) in
                if let memSnapshot = snapshot.value as? [String : AnyObject] {
                    if let title = memSnapshot["name"] as? String {
                        self.navigationItem.title = title + "'s Groups"
                    }

                }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }

    var presentr : Presentr?
    
    @IBAction func newGroup(_ sender: Any) {
        let alert = UIAlertController(title: "Create or Join?", message: "Would you like to create a group or join one?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (_) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateViewController") as! NewGroupViewController
            vc.type = .create
            self.presentr = Presentr(presentationType: .popup)
            self.customPresentViewController(self.presentr!, viewController: vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Join", style: .default, handler: {(_) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JoinViewController") as! NewGroupViewController
            vc.type = .join
            self.presentr = Presentr(presentationType: .popup)
            self.customPresentViewController(self.presentr!, viewController: vc, animated: true, completion: nil)
        }))
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("PReparing")
        if let SVC = (segue.destination as? UINavigationController)?.visibleViewController as? SearchViewController {
            SVC.searchGroup = sender as! StudyGroup
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
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
        if group.searching {
            performSegue(withIdentifier: "Search", sender: group)
        }else{
            let alert = UIAlertController(title: "New Active Session?", message: "Would you like to create a new Active Study Session?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateSessionViewController") as! NewSessionViewController
                vc.course = group.course ?? ""
                self.presentr = Presentr(presentationType: .bottomHalf)
                self.customPresentViewController(self.presentr!, viewController: vc, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            present(alert, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

