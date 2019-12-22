//
//  HomeViewController.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 20/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    let images = [UIImage(named: "01"), UIImage(named: "02"), UIImage(named: "03"), UIImage(named: "04"), UIImage(named: "05"), UIImage(named: "06"), UIImage(named: "07"), UIImage(named: "08"), UIImage(named: "09"), UIImage(named: "10"), UIImage(named: "11"), UIImage(named: "12"), UIImage(named: "13"), UIImage(named: "14")]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
    }

    func setupNavigationBar() {
        title = "Rijksmuseum Collection"
        navigationController?.navigationBar.barTintColor = .lightGray
    }

    func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.register(ImagePreviewCell.nib, forCellWithReuseIdentifier: ImagePreviewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePreviewCell.identifier, for: indexPath) as! ImagePreviewCell
        cell.imageView.image = images[indexPath.row]
        cell.title.text = "Title"
        cell.subtitle.text = "Subtitle"

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension HomeViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return images[indexPath.item]?.size.height ?? 150
    }
}
