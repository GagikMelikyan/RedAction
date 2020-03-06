//
//  MenuBar.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/15/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import Foundation
import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black//UIColor (red: 231/255.0, green: 22/255.0, blue: 17/255.0, alpha: 1)
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    let reuseIdentifier = "cellId"
    let buttonTitles = ["A LA UNE", "MON ACTU", "PREMIUM ", "POPULAIRES"]
    var homeController: HomeScreenViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        //let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        //collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
        setUpHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    
    private func setUpHorizontalBar() {
        let horizontalView = UIView()
        horizontalView.backgroundColor = .white
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalView)
        
        horizontalBarLeftAnchorConstraint = horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor); horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MenuBarCell else {
            fatalError("This cell is not an instance of MenuBarCell.")
        }
        
        cell.menuButton.text = buttonTitles[indexPath.item]
        cell.tintColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        //        let x = CGFloat(indexPath.item) * frame.width / 4
        //        horizontalBarLeftAnchorConstraint?.constant = x
        //
        //        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        //            self.layoutIfNeeded()
        //        }, completion: nil)
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
}
