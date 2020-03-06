//
//  FeedCellMonActu.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 12/24/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class FeedCellMonActu: FeedCell {
    
    let monActuId = "HomeScreenCell"
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        setUpCollectionView()
        getNews()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monActuId, for: indexPath) as? HomeScreenCell else {
            fatalError("This cell is not an instance of HomeScreenCell.")
        }
        
        cell.titleLabel.text = allNews[indexPath.item].title.htmlToString
        
        let taggableString = " Turquie/Politique "
        cell.textLabel.text = taggableString + " - " + allNews[indexPath.item].desc.htmlToString.maxLength(length: 150) + " ..."
        cell.textLabel.setSubTextColor(pSubString : taggableString, textColor : .white, backgroundColor : UIColor (red:153/255.0, green:153/255.0, blue: 153/255.0, alpha: 1))
        
        let imageUrl = allNews[indexPath.item].featuredImgSrc
        if let url = URL(string: imageUrl) {
            cell.cellImage.load(url: url)
        }
        
        
        cell.configureCell()
        
        return cell
    }
    
    // Make settings of collection view
    func setUpCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            let w = UIScreen.main.bounds.width
            flowLayout.estimatedItemSize = CGSize(width: w, height: 380)
        }
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    // Get data from WP Rest API
    private func getNews() {
        
        APIManager.sharedInstance.fetchNews(withUrl: "https://www.redaction.media/wp-json/edition/v2/posts-premium") { (news, error) in
            if let error = error {
                //got an error in getting the data, need to handle it
                print("error calling POST on /todos")
                print(error)
                return
            }
            
            guard let news = news else {
                print("error getting user: result is nil")
                return
            }
            
            print("News = \(news)")
            for eachNews in news {
                self.allNews.append(eachNews)
            }
            
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
            })
        }
    }
}
