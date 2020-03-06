//
//  HomeScreenCell.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/13/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class HomeScreenCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var contactView: UIView!
    
    var isHeightCalculated: Bool = false
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var frame = layoutAttributes.frame
            frame.size.height = ceil(size.height)
            layoutAttributes.frame = frame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}

