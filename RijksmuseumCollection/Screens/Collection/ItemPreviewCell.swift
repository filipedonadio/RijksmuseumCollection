//
//  ItemPreviewCell.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 21/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

class ItemPreviewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!

    var item: ItemPreview? {
        didSet {
            guard let item = item else { return }

            if let imageData = item.image {
                imageView.image = UIImage(data: imageData)
            }

            title.text = item.title
            subtitle.text = item.subtitle
        }
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
    }
}
