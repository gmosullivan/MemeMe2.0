//
//  MemeDetailViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 18/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var savedMemeImageView: UIImageView!
    
    var savedMeme: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedMeme = savedMeme {
            savedMemeImageView.image = savedMeme
        }
    }
    
}
