//
//  MenuBar.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 23/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

class MenuBar: UIView {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    // The view controller managed by this menu
    var targetViewController: CollectionViewController?

    let menuCellId = "menuCellId"
    let menuItemLeftSpacing: CGFloat = 10
    let menuItemRightSpacing: CGFloat = 10
    let menuFont = UIFont(name: "AvenirNext-Medium", size: 14)
    let menuItems: [CollectionObjectType] = [.painting, .box, .brooch, .candlestick, .cup, .demonstrationModel, .figure, .fragment, .furniture, .jeton, .jewellery]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        addSubview(collectionView)
        setupLayout()

        // The first menu item is highlighted initially
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
    }

    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension MenuBar: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
        cell.label.text = menuItems[indexPath.row].rawValue.capitalized
        return cell
    }
}

extension MenuBar: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedType = menuItems[indexPath.item]
        targetViewController?.loadCollection(with: selectedType)
    }
}

extension MenuBar: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // Calculate the item text size for each item
        let menuItemTextSize = menuItems[indexPath.row].rawValue.size(withAttributes: [
            NSAttributedString.Key.font : menuFont!
        ])
        let menuItemWidth = menuItemLeftSpacing + menuItemTextSize.width + menuItemRightSpacing

        return CGSize(width: menuItemWidth, height: self.frame.height)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
