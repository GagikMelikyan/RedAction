//
//  ArticleViewCell.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/25/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class ArticleViewCell: UICollectionViewCell {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var commemorationsLable: UILabel!
    
    func configureArticleCell(_ dataString: String) {
        self.textLabel.text = dataString
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
