//
//  ViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 18/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class MemeCreatorViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageForMemeImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar:UIToolbar!
    
    // MARK: Variables and Constants
    
    var memedImage: UIImage?
    var imageSelected = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        configureTextField(topTextField, withText: "TOP")
        configureTextField(bottomTextField, withText: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMeme))
        tabBarController?.tabBar.isHidden = true
        let photoLibraryButton = UIBarButtonItem(title: "Choose", style: .plain, target: self, action: #selector(pickImageFromLibrary))
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takeNewImage))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let items = [photoLibraryButton, flexibleSpace, cameraButton]
        toolbar.setItems(items, animated: false)
        navigationItem.rightBarButtonItem?.isEnabled = imageSelected
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    // MARK: - Meme Functions
    
    func save() {
        let memeToSave = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageForMemeImageView.image!, memedImage: memedImage!)
        appDelegate.Memes.append(memeToSave)
    }
    
    func generateMemedImage() -> UIImage {
        hideBars(true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let generatedMeme = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideBars(false)
        return generatedMeme
    }
    
    // MARK: - UI functions
    
    func configureTextField(_ textField: UITextField, withText: String) {
        let memeAttributes:[String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -3.0
        ]
        textField.defaultTextAttributes = memeAttributes
        textField.textAlignment = .center
        textField.text = withText
        textField.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Keyboard Notification Functions
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CG Rect
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = -1 * getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    // MARK: - Subscription Functions
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Helper Functions to Avoid Repetition
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func hideBars(_ isHidden: Bool) {
        navigationController?.navigationBar.isHidden = isHidden
        toolbar.isHidden = isHidden
    }
    
    // MARK: - Action Button Functions (objective c)
    
    @objc func pickImageFromLibrary() {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    @objc func takeNewImage() {
        presentImagePickerWith(sourceType: .camera)
    }
    
    @objc func shareMeme () {
        let generatedMeme = generateMemedImage()
        memedImage = generatedMeme
        let activityController = UIActivityViewController(activityItems: [generatedMeme], applicationActivities: nil)
        activityController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success && error == nil {
                self.save()
                self.dismiss(animated: true, completion: nil)
            } else if error != nil {
                // Handle error
            }
        }
        present(activityController, animated: true, completion: nil)
    }
    
    // MARK: - Text Field Delegate Functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Image Picker Delegate Functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageForMemeImageView.image = image
            imageSelected = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

