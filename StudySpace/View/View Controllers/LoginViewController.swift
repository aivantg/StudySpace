//
//  LoginViewController.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/28/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(_ sender: Any) {
        guard let email = emailText.text else { return }
        guard let pass = passwordText.text else { return }
        FIRAuth.auth()!.createUser(withEmail: email, password: pass) { (user, error) in
            guard error != nil else {
                print("Error Creating User: \(error!)")
                return
            }
            print("CREATED USER \(user?.id ?? "NOID")")
            FIRDatabase.database().reference(withPath: "users").child(user?.uid ?? "id").child("year").setValue(2021)
            self.performSegue(withIdentifier: "openHome", sender: self)
        }
    }
    @IBAction func login() {
        guard let email = emailText.text else { return }
        guard let pass = passwordText.text else { return }
        FIRAuth.auth()!.signIn(withEmail: email, password: pass) { (user, error) in
            guard error != nil else {
                print("Error Signing In User: \(error!)")
                return
            }
            self.performSegue(withIdentifier: "openHome", sender: self)
        }
    }

}
