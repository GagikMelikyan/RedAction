//
//  FeedCellHomeScreen.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 7/22/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class FeedCellHomeScreen: FeedCell {
    
    let homeId = "HomeScreenCell"
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        setUpCollectionView()
        getNews()
        
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeId, for: indexPath) as? HomeScreenCell else {
            fatalError("This cell is not an instance of HomeScreenCell.")
        }
        
        cell.titleLabel.text = allNews[indexPath.item].title.htmlToString
        cell.textLabel.text = allNews[indexPath.item].desc.htmlToString.maxLength(length: 120) + " ..."
        
        
        
        
        let imageUrl = allNews[indexPath.item].featuredImgSrc
        let url = URL(string: imageUrl)
        cell.cellImage.load(url: url!)
        
        cell.textLabel.setSubTextColor(pSubString : "Turquie/Politique", textColor : .white, backgroundColor : UIColor (red:153/255.0, green:153/255.0, blue: 153/255.0, alpha: 1))
        cell.textLabel.setSubTextColor(pSubString: "Turquie/Société", textColor : .white, backgroundColor : UIColor (red:157/255.0, green:153/255.0, blue: 153/255.0, alpha: 1))
        
        cell.configureCell()
        
        return cell
    }
    
    // Make settings of collection view
    func setUpCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            let w = UIScreen.main.bounds.width - 10
            flowLayout.estimatedItemSize = CGSize(width: w, height: 380)
        }
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    // Get data from WP Rest API
    private func getNews() {
        
        APIManager.sharedInstance.fetchNews(withUrl: "https://www.redaction.media/wp-json/articles/v2/posts") { (news, error) in
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
