//
//  NewGroupViewController.swift
//  StudySpace
//
//  Created by Aivant Goyal on 10/27/17.
//  Copyright © 2017 aivantgoyal. All rights reserved.
//

import UIKit

class NewGroupViewController: MainViewController {

    @IBOutlet weak var segControl: FFAPSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segControl.listOptions = ["Join Group", "Create Group"]
        segControl.normalBackgroundColor = UIColor(red: 0, green: 149/255, blue: 207/255, alpha: 1)
        segControl.normalTextColor = UIColor.white
        segControl.normalBorderColor = UIColor.white
        segControl.selectedBackgroundColor = UIColor(red: 0, green: 180/255, blue: 238/255, alpha: 1)
        segControl.selectedBorderColor = UIColor.white
        segControl.selectedTextColor = UIColor.white
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
