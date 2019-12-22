//
//  ImagePreviewCell.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 21/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import UIKit

class ImagePreviewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!

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
