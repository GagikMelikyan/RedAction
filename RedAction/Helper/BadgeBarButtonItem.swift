//
//  BadgeBarButtonItem.swift
//  Red'Action
//
//  Created by Karen Madoyan on 7/16/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

public class BadgeBarButtonItem: UITabBarItem
{
    @IBInspectable
    public var badgeNumber: Int = 0 {
        didSet {
            self.updateBadge()
        }
    }
    
    private let label: UILabel
    
    required public init?(coder aDecoder: NSCoder)
    {
        let label = UILabel()
        label.backgroundColor = .clear
        label.alpha = 0.9
//        label.layer.cornerRadius = 9
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .darkGray
        label.layer.zPosition = 1
        self.label = label
        
        super.init(coder: aDecoder)
        
        self.addObserver(self, forKeyPath: "view", options: [], context: nil)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        self.updateBadge()
    }
    
    private func updateBadge()
    {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        self.label.text = "\(badgeNumber)"
        
        if self.badgeNumber > 0 && self.label.superview == nil
        {
            view.addSubview(self.label)
            
            self.label.widthAnchor.constraint(equalToConstant: 30).isActive = true
            self.label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 24).isActive = true
            self.label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -6).isActive = true
        }
        else if self.badgeNumber == 0 && self.label.superview != nil
        {
            self.label.removeFromSuperview()
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "view")
    }
}
