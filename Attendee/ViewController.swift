//
//  ViewController.swift
//  Attendee
//
//  Created by William Fernandez on 1/30/20.
//  Copyright © 2020 SparkDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segue: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


    @IBAction func segue(_ sender: Any) {
        self.performSegue(withIdentifier: "goToEventCreation", sender: sender)

    }
}

