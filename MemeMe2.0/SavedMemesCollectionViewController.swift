//
//  SavedMemesCollectionViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 18/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class SavedMemesCollectionViewController: UICollectionViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Variables and Constants
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cellIdentifier = "CollectionViewCell"
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        tabBarController?.tabBar.isHidden = false
        let space: CGFloat = 3.0
        let width = (view.frame.size.width - (2 * space)) / 3
        let height = (view.frame.size.height - (2 * space)) / 6
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.Memes.count
    }
    
    // MARK: - Collection View Data Source Functions

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        let savedMeme = appDelegate.Memes[indexPath.row]
        cell.cellImageView.image = savedMeme.memedImage
        return cell
    }
    
    // MARK: - Collection View Delegate Functions
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let savedMeme = appDelegate.Memes[indexPath.row]
        controller.savedMeme = savedMeme
        navigationController?.pushViewController(controller, animated: true)
    }

}
