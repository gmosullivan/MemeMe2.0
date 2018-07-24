//
//  MemeEditorViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 23/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate {
    
    var memeToEdit: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Meme"
        
    }
    
}
