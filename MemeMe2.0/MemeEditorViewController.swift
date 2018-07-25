//
//  MemeEditorViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 23/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var memeToEditImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var memeToEdit: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeToEditImageView.image = memeToEdit.originalImage
        configureTextField(topTextField, withText: memeToEdit.topText)
        configureTextField(bottomTextField, withText: memeToEdit.bottomText )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Edit Meme"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Saved Memes", style: .plain, target: self, action: #selector(returnToRootViewController))
    }
    
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
    
    @objc func returnToRootViewController() {
        let controller = navigationController
        controller?.popToRootViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
}
