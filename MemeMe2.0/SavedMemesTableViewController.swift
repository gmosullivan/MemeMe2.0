//
//  SavedMemesTableViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 18/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class SavedMemesTableViewController: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newMeme = Meme(topText: "Put 5 dollars in pocket", bottomText: "Pull out 10", originalImage: UIImage(named: "originalImage")!, memedImage: UIImage(named: "memedImage")!)
        appDelegate.Memes.append(newMeme)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.Memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Saved Meme Cell", for: indexPath)
        let savedMeme = appDelegate.Memes[indexPath.row]
        cell.imageView?.image = savedMeme.memedImage
        cell.textLabel?.text = savedMeme.topText + savedMeme.bottomText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let savedMeme = appDelegate.Memes[indexPath.row]
        controller.savedMeme = savedMeme.memedImage
        navigationController?.pushViewController(controller, animated: true)
    }

}
