//
//  HomeViewController.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 20/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

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
        collectionView.backgroundColor = .lightGray
        collectionView.register(ImagePreviewCell.nib, forCellWithReuseIdentifier: ImagePreviewCell.identifier)
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePreviewCell.identifier, for: indexPath) as! ImagePreviewCell
        cell.imageView.image = UIImage(named: "placeholder")
        cell.title.text = "Title"
        cell.subtitle.text = "Subtitle"

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize + 100)
    }
}
