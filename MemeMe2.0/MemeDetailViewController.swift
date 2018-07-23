//
//  MemeDetailViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 18/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var savedMemeImageView: UIImageView!
    
    // MARK: - Variables and Constants
    
    var savedMeme: Meme!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedMeme = savedMeme {
            savedMemeImageView.image = savedMeme.memedImage
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMeme))
    }
    
    @objc func editMeme() {
        performSegue(withIdentifier: "EditMeme", sender: nil)
    }
    
}
