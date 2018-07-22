//
//  ViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 18/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class MemeCreatorViewController: UIViewController {
    
    @IBOutlet weak var toolbar:UIToolbar!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

