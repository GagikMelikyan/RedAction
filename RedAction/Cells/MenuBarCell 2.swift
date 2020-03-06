//
//  MenuBarCell.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/15/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    let menuButton: UILabel = {
        let mb = UILabel()
        mb.text = "A la une"
        mb.textColor = .white
        mb.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        mb.textAlignment = .center
        
        return mb
    }()
    
    //    override var isHighlighted: Bool{
    //        didSet{
    //            if isHighlighted{
    //                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
    //                    self.transform = self.transform.scaledBy(x: 0.75, y: 0.75)
    //                }, completion: nil)
    //            }else{
    //                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
    //                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
    //                }, completion: nil)
    //            }
    //        }
    //    }
    
    override var isHighlighted: Bool {
        didSet {
            print("123")
            self.menuButton.textColor = self.isHighlighted ? UIColor (red: 91/255.0, green: 14/255.0, blue: 13/255.0, alpha: 1) : UIColor.white
        }
    }
    
    //    override var isSelected: Bool {
    //        didSet {
    //            menuButton.textColor = isSelected ? UIColor (red: 91/255.0, green: 14/255.0, blue: 13/255.0, alpha: 1) : UIColor.white
    //        }
    //    }
    
    private func setUpViews() {
        addSubview(menuButton)
        //addConstraintsWithFormat("H:|[v0]|", views: menuButton)
        //addConstraintsWithFormat("V:|[v0]|", views: menuButton)
        addConstraintsWithFormat("H:|-1-[v0]-1-|", views: menuButton)
        addConstraintsWithFormat("V:|-1-[v0]-1-|", views: menuButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
