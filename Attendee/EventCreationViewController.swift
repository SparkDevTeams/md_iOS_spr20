//
//  EventCreationViewController.swift
//  Attendee
//
//  Created by William Fernandez on 1/30/20.
//  Copyright © 2020 SparkDev. All rights reserved.
//

import UIKit
import FSCalendar
import Firebase
import FirebaseStorage

class EventCreationViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var editEventDescription: UITextView!
    @IBOutlet weak var editEventTitle: UITextField!
    @IBOutlet weak var eventQRImage: UIImageView!
    @IBOutlet weak var eventQRUniqueIdentifier: UITextField!
    @IBOutlet weak var QRCodeCheckmark: UIImageView!
    @IBOutlet weak var editEventHost: UITextField!
    @IBOutlet weak var editEventLocation: UITextField!
    
    
    private var selectedDate: Date?
    private var QRImageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update the UI
        updateUI()
        
        // Set the calendar's dataSource and delegate
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        
        // Set the status bar to be white
        UIApplication.shared.statusBarStyle = .lightContent

        // Set placeholder for textview
        editEventDescription.delegate = self
        editEventDescription.text = "Add an event description.."
        editEventDescription.textColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 0.5)
        
        // Style navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor(rgb: 0x6AA6DE)

    }
 
    // Actions to execute after pressing the save button
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if validEventForm() {
            let newEvent = Event(eventName: editEventTitle.text!, eventDate: selectedDate!, eventDescription: editEventDescription.text!, eventHost: editEventHost.text!, eventLocation: editEventLocation.text!, eventQRCode: QRImageUrl!)
            uploadEventToFirebase(event: newEvent)
        }
    }
    @IBAction func generateQRButtonPressed(_ sender: Any) {
        if (eventQRUniqueIdentifier.text! != "") {
            if let myString = eventQRUniqueIdentifier.text
            {
                let data = myString.data(using: .ascii, allowLossyConversion: false)
                let filter = CIFilter(name: "CIQRCodeGenerator")
                filter?.setValue(data, forKey: "inputMessage")
                let ciImage = filter?.outputImage
                let transform = CGAffineTransform(scaleX: 10, y: 10)
                let transformImage = ciImage?.transformed(by: transform)
                           
                let img = UIImage(ciImage: transformImage!)
                eventQRImage.image = img
                
                QRImageUrl = UUID().uuidString
                QRCodeCheckmark.isHidden = false
                
            }
        } else {
            AlertService.showAlert(style: .alert, title: "Error", message: "You must provide a unique QR code string.")
        }
        
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
    // Takes in the newly created NewEvent Struct and uploads it to Firebase
    func uploadEventToFirebase(event: Event) {
        
    }
    
    func uploadPhoto() {
        // Get the image, convert it into data, and compress it
        guard let image = eventQRImage.image, let data = image.jpegData(compressionQuality: 1.0) else {
            print("Something went wrong")
            return
        }
        
        //Generate the random UUID String for the image
        let imageName = UUID().uuidString
        // Reference the storage
        let imageReference = Storage.storage().reference().child(imageName)
        
        // Upload the data to Firebase Storage
        imageReference.putData(data, metadata: nil) { (metadata, err) in
            if let err = err {
                print(err)
            }
            
            imageReference.downloadURL(completion: { (url, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                guard let url = url else {
                    print("Something went wrong")
                    return
                }
                
                let dataReferenece = Firestore.firestore().collection("events").document(self.userID)
                let documentUID = dataReferenece.documentID
                let urlString = url.absoluteString
                
                let data = [
                    "profilePhotoID" : documentUID,
                    "profilePhotoURL" : urlString
                ]
                
                dataReferenece.updateData(data) { (err) in
                    if let err = err {
                        print(err)
                    } else {
                        print("Document successfully updated")
                    }
                    
                    print("Success")
                }
            })
        }
    }
    
    func validEventForm() -> Bool {
        if (editEventTitle.text! == "" || editEventDescription.text! == "" || editEventHost.text! == "" || selectedDate == nil || editEventLocation.text! == "" || QRImageUrl == "")  {
            AlertService.showAlert(style: .alert, title: "Error", message: "You must fill out all the forms!")
            return false
        }
        return true
       
    }
    
    func updateUI() {
       
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
// Extension to manage the FSCalendar
extension EventCreationViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
    }
}
