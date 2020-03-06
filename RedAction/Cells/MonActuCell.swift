//
//  MonActuCell.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 12/24/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class MonActuCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var arrowLabel: UILabel!
    @IBOutlet var smallTitleLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var contactView: UIView!
    
    var isHeightCalculated: Bool = false
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        setUpArrowLabel()
    }
    
    func setUpArrowLabel() {
        
        arrowImageView.image = UIImage.triangle(side: 50.0, color: UIColor.white)
        
    }
    
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
