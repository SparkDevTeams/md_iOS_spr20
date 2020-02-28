//
//  EventCreationViewController.swift
//  Attendee
//
//  Created by William Fernandez on 1/30/20.
//  Copyright © 2020 SparkDev. All rights reserved.
//

import UIKit
import FSCalendar

class EventCreationViewController: UIViewController, UITextViewDelegate, FSCalendarDelegate, FSCalendarDataSource  {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var editEventDescription: UITextView!
    @IBOutlet weak var editEventTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set placeholder for textview
//        editEventDescription.delegate = self
//        editEventDescription.text = "Add an event description.."
//        editEventDescription.textColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 0.5)
        
        // Style navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor(rgb: 0x6AA6DE)

    }
    
    // Show action sheet when the image button is pressed
    @IBAction func showImagePickerController(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }
    

    // Settings for when the textview is selected
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 0.5) {
            textView.text = nil
            textView.textColor = UIColor(rgb: 0x6AA6DE)
        }
    }
    // Settings for when the textview is done being selected
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add an event description.."
            textView.textColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 0.5)
        }
    }
    

}
// Create the extension to use hexadecimal colors in UIColor()
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

// Create the extension to present the action sheet for choosing/taking a picture. Can be used throughout the entire app
extension EventCreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet() {
        let photoLibraryAction = UIAlertAction(title: "Choose from library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take with camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertService.showAlert(style: .actionSheet, title: "Choose image", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            eventImage.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            eventImage.image = originalImage
        }
        dismiss(animated: true, completion: {
            
        })
    }
    
    
}