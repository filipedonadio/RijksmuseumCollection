//
//  HomeViewController.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 20/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    let images = [UIImage?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
    }

    func setupNavigationBar() {
        let logoFrame = CGRect(x: 0, y: 0, width: 155, height: 20)
        let logoContainer = UIView(frame: logoFrame)
        let imageView = UIImageView(frame: logoFrame)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
    }

    func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.register(ImagePreviewCell.nib, forCellWithReuseIdentifier: ImagePreviewCell.identifier)
        collectionView.backgroundColor = .black
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
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
