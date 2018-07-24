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
    
    var memeToEdit: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeToEditImageView.image = memeToEdit.originalImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Edit Meme"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Saved Memes", style: .plain, target: self, action: #selector(returnToRootViewController))
    }
    
    @objc func returnToRootViewController() {
        let controller = navigationController
        controller?.popToRootViewController(animated: true)
    }
    
}
