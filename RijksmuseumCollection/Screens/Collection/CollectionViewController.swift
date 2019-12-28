//
//  CollectionViewController.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 20/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    let menuBar = MenuBar()
    let menuBarHeight: CGFloat = 50
    let defaultCellHeight: CGFloat = 150
    let cellTextHeight: CGFloat = 65

    var viewModel: CollectionViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    var items = [ItemPreview]() {
        didSet {
            if let layout = collectionView.collectionViewLayout as? PinterestLayout {
                layout.reset()
            }
            collectionView.reloadData()
            
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupMenu()
        setupCollectionView()
        loadCollection(with: .painting)
    }

    func loadCollection(with type: CollectionObjectType) {
        viewModel?.fetchCollection(type: type)
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

    func setupMenu() {
        menuBar.targetViewController = self

        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: menuBarHeight),
        ])
    }

    func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }

        let topSpacing: CGFloat = 6
        let topInset = menuBarHeight + topSpacing
        collectionView?.contentInset = UIEdgeInsets(top: topInset, left: 10, bottom: 10, right: 10)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .black
        collectionView.indicatorStyle = .white
        collectionView.register(ItemPreviewCell.nib, forCellWithReuseIdentifier: ItemPreviewCell.identifier)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemPreviewCell.identifier, for: indexPath) as! ItemPreviewCell
        cell.item = items[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension CollectionViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let imageData = items[indexPath.item].image else { return defaultCellHeight }
        guard let imageHeight = UIImage(data: imageData)?.size.height else { return defaultCellHeight }

        return imageHeight + cellTextHeight
    }
}

extension CollectionViewController: CollectionViewModelDelegate {

    func onFetchCompleted(with collection: [ItemPreview]) {
        items = collection
    }

    func onFetchFailed(with reason: String) {
        // TODO: Show error message
    }
}
