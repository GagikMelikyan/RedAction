//
//  FeedCell.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 12/20/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var allNews = [News] ()
    let cellIdentifier = "homeCell"
    var cellDelegate : CellDelegate?
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? HomeScreenCell else {
            fatalError("This cell is not an instance of HomeScreenCell.")
        }
        
        cell.titleLabel.text = allNews[indexPath.item].title.htmlToString
        cell.textLabel.text = allNews[indexPath.item].desc.htmlToString
        
        let imageUrl = allNews[indexPath.item].featuredImgSrc
        let url = URL(string: imageUrl)
        cell.cellImage.load(url: url!)
        
        cell.textLabel.setSubTextColor(pSubString : "Turquie/Politique", textColor : .white, backgroundColor : UIColor (red:153/255.0, green:153/255.0, blue: 153/255.0, alpha: 1))
        cell.textLabel.setSubTextColor(pSubString: "Turquie/Société", textColor : .white, backgroundColor : UIColor (red:157/255.0, green:153/255.0, blue: 153/255.0, alpha: 1))
        
        cell.configureCell()
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articleId = allNews[indexPath.item].id
        let defaults = UserDefaults.standard
        defaults.set(articleId, forKey: "ArticleId")
        tapLabel()
    }
    
    @objc func tapLabel() {
        cellDelegate?.tapFunction()
    }
    
    @objc func loadList(notification: NSNotification) {
        collectionView.reloadData()
    }
}
