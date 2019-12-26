//
//  MenuCell.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 23/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {

    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 14)
        lbl.textColor = .lightText
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    // This is the small circle below the highlighted menu item
    let circle: UIView = {
        let indicatorCircle = UIView()
        indicatorCircle.backgroundColor = .orange
        indicatorCircle.clipsToBounds = true
        indicatorCircle.layer.cornerRadius = 1.5
        return indicatorCircle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    private func highlightItem() {
        label.textColor = .orange
        addSubview(circle)

        circle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circle.widthAnchor.constraint(equalToConstant: 3),
            circle.heightAnchor.constraint(equalToConstant: 3),
            circle.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            circle.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    private func unhighlightItem() {
        label.textColor = .lightText
        circle.removeFromSuperview()
    }

    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? highlightItem() : unhighlightItem()
        }
    }

    override var isSelected: Bool {
        didSet {
            isSelected ? highlightItem() : unhighlightItem()
        }
    }
}
