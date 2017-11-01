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
        if FIRAuth.auth()?.currentUser != nil {
            do{
                try FIRAuth.auth()?.signOut()
            }catch {
            print("ERror: Sign out failed")
            }
            
        }
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
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            print("CREATED USER \(user?.uid ?? "NOID")")
            FIRDatabase.database().reference(withPath: "users").child(user?.uid ?? "id").child("year").setValue(2021)
            self.performSegue(withIdentifier: "openHome", sender: self)
        }
    }
    @IBAction func login() {
        if emailText.text == nil || emailText.text == "" {
            emailText.text = "demo@berkeley.edu"
            passwordText.text = "password"
        }
        guard let email = emailText.text else { return }
        guard let pass = passwordText.text else { return }
        FIRAuth.auth()!.signIn(withEmail: email, password: pass) { (user, error) in
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            self.performSegue(withIdentifier: "openHome", sender: self)
        }
    }

}
