//
//  ItemHeader.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 09/01/20.
//  Copyright © 2020 Filipe Donadio. All rights reserved.
//

import UIKit

class ItemHeader: UIView {

    private let headerImage: UIImage

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 6
        return iv
    }()

    init(frame: CGRect, headerImage: UIImage) {
        self.headerImage = headerImage
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let aspectRatio = headerImage.size.width / headerImage.size.height
        let imageHeight = frame.width / aspectRatio
        
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: imageHeight)
        imageView.image = headerImage
        frame = imageView.frame

        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
