//
//  ArticleVC.swift
//  RedAction
//
//  Created by User on 11/16/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class ArticleVC: UIViewController, NewArticleViewControllerDelegate {
    
    @IBOutlet weak var ariticleImageView: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleText: UILabel!
    
    var articleId: Int?
    var data = [Article]()
    weak var subscriptionDelegate: SubscriptionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        getArticle()
        navigationController?.navigationBar.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArticleVC.goToArticleDetail))
        articleText.isUserInteractionEnabled = true
        articleText.addGestureRecognizer(tap)
        
        
        //Mark: For test
        ariticleImageView.isUserInteractionEnabled = true
    }
    
    
    @objc func goToArticleDetail(sender:UITapGestureRecognizer) {
        let newArticleNVC = self.storyboard?.instantiateViewController(withIdentifier: NewArticleNC.id) as! NewArticleNC
        let newArticleVC = newArticleNVC.viewControllers.first as! NewArticleViewController
        //        let id = UserDefaults.standard.integer(forKey: "ArticleId")
        newArticleVC.delegate = self
        newArticleVC.subscriptionDelegate = subscriptionDelegate
        newArticleVC.articleText = articleText.text
        newArticleVC.article = data[0]
        //        newArticleVC.articleTitle =  articleTitle.text
        //        newArticleVC.articleImg = ariticleImageView.image
        self.present(newArticleNVC, animated: true, completion: nil)
        
    }
    
    // Get data from WP Rest API
    private func getArticle() {
        
        APIManager.sharedInstance.fetchEachNews(id: articleId!) { (article, error) in
            if let error = error {
                // got an error in getting the data, need to handle it
                print("error calling POST on /todos")
                print(error)
                return
            }
            guard let article = article else {
                print("error getting article: result is nil")
                return
            }
            
            self.data.removeAll()
            self.data.append(article)
            
            DispatchQueue.main.async(execute: {
                let imageUrl = self.data[0].embedded.wpFeaturedmedia[0].sourceURL
                let url = URL(string: imageUrl) ?? URL(string: "")
                
                self.ariticleImageView.load(url: url!)
                self.articleTitle.text = self.data[0].title.rendered.htmlToString
                self.articleText.text = self.data.first!.content.rendered.htmlToString
                self.articleDate.text = "Public de \(self.getDatefromTimeStamp(str_date: self.data[0].date, strdateFormat: "dd/MM/yyyy HH:mm")) | Mis à jour le \(self.getDatefromTimeStamp(str_date: self.data[0].date_gmt, strdateFormat: "dd/MM/yyyy HH:mm"))"
            })
        }
    }
    
    //Mark: go to back
    @IBAction func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Mark: change date format
    func getDatefromTimeStamp (str_date : String , strdateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        
        let date = dateFormatter.date(from: str_date)
        dateFormatter.dateFormat = strdateFormat
        let datestr = dateFormatter.string(from: date!)
        return datestr
    }
    
    
    //MARK: Delegate
    
    func goToComments() {
        let articleCommentNC = self.storyboard?.instantiateViewController(withIdentifier: ArticleCommentNC.id) as! ArticleCommentNC
        let articleCommentVC = articleCommentNC.viewControllers.first as! ArticleCommentViewController
        //        let id = UserDefaults.standard.integer(forKey: "ArticleId")
        articleCommentVC.article = data[0]
        articleCommentVC.articleTitleText =  articleTitle.text
        articleCommentVC.articleImg = ariticleImageView.image
        articleCommentVC.articleText =  articleText.text
        
        self.present(articleCommentNC, animated: true, completion: nil)
    }
    

}
