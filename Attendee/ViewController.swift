//
//  ViewController.swift
//  Attendee
//
//  Created by William Fernandez on 1/30/20.
//  Copyright © 2020 SparkDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eventEditTitle: UILabel!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var eventDateTime: UITextField!
    @IBOutlet weak var eventDesc: UITextField!
    @IBOutlet weak var eventCap: UITextField!
    @IBOutlet weak var eventAlert: UITextField!
    @IBOutlet weak var eventURL: UITextField!
    @IBOutlet weak var eventNotes: UITextField!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDetails: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveDetails(_ sender: Any) {
    }
}

