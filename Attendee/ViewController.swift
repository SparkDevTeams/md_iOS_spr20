//
//  ViewController.swift
//  Attendee
//
//  Created by William Fernandez on 1/30/20.
//  Copyright © 2020 SparkDev. All rights reserved.
//
import AVFoundation
import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    func showName(){
        let userID : String = (FIRAuth.auth()?.currentUser?.uid)!
         print("Current user ID is" + userID)

        self.dbRef?.child("profile").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
             print(snapshot.value)

             let userEmail = (snapshot.value as! NSDictionary)["addedByUser"] as! String
             print(userEmail)


         })
    }
    


}

