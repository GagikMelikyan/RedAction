//
//  FeedCellPremium.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 7/22/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class FeedCellPremium: FeedCell {
    
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
        
        let paidArticleSign = " R "
        let space = "  "
        let title = paidArticleSign + space + allNews[indexPath.item].title.htmlToString
        let paidArticleSignRange = (title as NSString).range(of: paidArticleSign)
        let fontAttribute = [NSAttributedStringKey.font: UIFont(name: "Merriweather-Bold", size: 21.0)]
        
        let myAttrString = NSMutableAttributedString(string: title, attributes: fontAttribute as [NSAttributedStringKey : Any])
        
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.backgroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont(name: "Merriweather-Bold", size: 19.0)! ]
        myAttrString.setAttributes(multipleAttributes as [NSAttributedStringKey : Any], range: paidArticleSignRange)
        cell.titleLabel.attributedText = myAttrString
        
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
        
        collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
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
                self.collectionView.reloadData()
            })
        }
    }
    
}
