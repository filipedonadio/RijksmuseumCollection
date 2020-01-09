//
//  ItemCell.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 06/01/20.
//  Copyright © 2020 Filipe Donadio. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    let itemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.textColor = .lightText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let itemData: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        stackView.addArrangedSubview(itemLabel)
        stackView.addArrangedSubview(itemData)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])

        self.backgroundColor = .black
    }

    static var identifier: String {
        return String(describing: self)
    }
}
