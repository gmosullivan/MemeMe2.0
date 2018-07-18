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
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
