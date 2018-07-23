//
//  ViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 18/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class MemeCreatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageForMemeImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar:UIToolbar!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        configureTextField(topTextField, withText: "TOP")
        configureTextField(bottomTextField, withText: "BOTTOM")
    }
    
    //Edit camera button
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        navigationItem.rightBarButtonItem?.isEnabled = false
        tabBarController?.tabBar.isHidden = true
        let photoLibraryButton = UIBarButtonItem(title: "Choose", style: .plain, target: self, action: nil)
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let items = [photoLibraryButton, flexibleSpace, cameraButton]
        toolbar.setItems(items, animated: false)
        cameraButton.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
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
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }

}

