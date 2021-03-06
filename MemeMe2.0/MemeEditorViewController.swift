//
//  MemeEditorViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 23/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var memeToEditImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // MARK: - Variables and constants
    
    var memeToEdit: Meme!
    var memedImage: UIImage?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        memeToEditImageView.image = memeToEdit.originalImage
        configureTextField(topTextField, withText: memeToEdit.topText)
        configureTextField(bottomTextField, withText: memeToEdit.bottomText )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        navigationItem.title = "Edit Meme"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Saved Memes", style: .plain, target: self, action: #selector(returnToRootViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMeme))
        memedImage = memeToEdit.memedImage
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()    
    }
    
    // MARK: - Meme Functions
    
    func save() {
        let editedMeme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeToEdit.originalImage, memedImage: memedImage!)
        appDelegate.Memes.append(editedMeme)
    }
    
    func generateMeme() -> UIImage {
        hideBars(true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let generatedMeme = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideBars(false)
        return generatedMeme
    }
    
    // MARK: - UI Functions
    
    func configureTextField(_ textField: UITextField, withText: String) {
        let memeTextAttributes: [String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -3.0
        ]
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = withText
        textField.adjustsFontSizeToFitWidth = true
    }
    
    func hideBars(_ shouldHide: Bool) {
        navigationController?.navigationBar.isHidden = shouldHide
        tabBarController?.tabBar.isHidden = shouldHide
    }
    
    // MARK: - Keyboard Notification Functions
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of cgRect
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
    
    // MARK: - Subscription Notifications
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Action Button Functions (objective c)
    
    @objc func returnToRootViewController() {
        let controller = navigationController
        controller?.popToRootViewController(animated: true)
    }
    
    @objc func shareMeme() {
        let generatedMeme = generateMeme()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
}
