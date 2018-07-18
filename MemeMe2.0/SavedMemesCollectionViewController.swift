//
//  SavedMemesCollectionViewController.swift
//  MemeMe2.0
//
//  Created by Gareth O'Sullivan on 18/07/2018.
//  Copyright © 2018 Locust Redemption. All rights reserved.
//

import UIKit

class SavedMemesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cellIdentifier = "CollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let space: CGFloat = 3.0
        let width = (view.frame.size.width - (2 * space))
        let height = (view.frame.size.height - (2 * space))
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
        let anotherMeme = Meme(topText: "Put 5 dollars in pocket", bottomText: "Pull out 10", originalImage: UIImage(named: "originalImage")!, memedImage: UIImage(named: "memedImage")!)
        appDelegate.Memes.append(anotherMeme)
        let anotherNewMeme = Meme(topText: "Put 5 dollars in pocket", bottomText: "Pull out 10", originalImage: UIImage(named: "originalImage")!, memedImage: UIImage(named: "memedImage")!)
        appDelegate.Memes.append(anotherNewMeme)
        let andAnotherMeme = Meme(topText: "Put 5 dollars in pocket", bottomText: "Pull out 10", originalImage: UIImage(named: "originalImage")!, memedImage: UIImage(named: "memedImage")!)
        appDelegate.Memes.append(andAnotherMeme)
        let oneMoreMeme = Meme(topText: "Put 5 dollars in pocket", bottomText: "Pull out 10", originalImage: UIImage(named: "originalImage")!, memedImage: UIImage(named: "memedImage")!)
        appDelegate.Memes.append(oneMoreMeme)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.Memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        let savedMeme = appDelegate.Memes[indexPath.row]
        cell.cellImageView.image = savedMeme.memedImage
        return cell
    }

}
