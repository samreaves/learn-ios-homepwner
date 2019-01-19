//
//  ItemDetailViewController.swift
//  Homepwner
//
//  Created by Sam Reaves on 1/13/19.
//  Copyright © 2019 Sam Reaves Digital. All rights reserved.
//

import UIKit

class ItemDetailViewController : UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Item and ImageStore dependencies
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    
    // MARK: - ImageViewController Logic
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        /* If the device has a camera, take a picture. Otherwise, source from the photo library */
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        /* Place image picker on the screen */
        present(imagePicker, animated: true, completion: nil)
    }
    
    /* Implement didFinishPickingMediaWithInfo for UIImagePickerController */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        /* Get picked image from dictionary */
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        /* Store the image */
        imageStore.setImage(image, forKey: item.itemKey)
        
        /* Place image inside image view */
        imageView.image = image
        
        /* Take image picker off the screen */
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Formatters
    /* Number formatter for value in dollars */
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    /* Date formatter for date created */
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    // MARK: - View Logic
    /* Just before view controller's view appears, load item information from ItemStore */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)

        /* Load image and set image view's image */
        let imageToDisplay = imageStore.image(forKey: item.itemKey)
        imageView.image = imageToDisplay
    }
    
    /* Just before view controller's view disappears, save user input to ItemStore */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* End edit mode of any active UITextField */
        view.endEditing(true)
        
        /* Save changes to item */
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    
    // MARK: - Dismiss Keyboard Logic
    /* On tap of background, end edit mode of any active UITextField */
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /* Just before return key on keyboard acts normally, have text field resign first responder */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
