//
//  NewArticleViewController.swift
//  RedAction
//
//  Created by User on 11/19/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

protocol NewArticleViewControllerDelegate: class {
    func goToComments()
}

protocol SubscriptionDelegate: class {
    func goToSubscriptionVC()
}

class NewArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TextClosingViewDelegate {
    
    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var articleContentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentstableView: UITableView!
    @IBOutlet weak var recommendeArticleTableView: UITableView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var readCommentsButton: UIButton!
    
    var articleText: String?
    var article: Article?
    //    var articleTitle: String?
    //    var articleImg: UIImage?
    var premiumStatus = false
    
    weak var delegate: NewArticleViewControllerDelegate?
    weak var subscriptionDelegate: SubscriptionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        shareButton.layer.cornerRadius = 0.5 * shareButton.bounds.size.width
        articleContent.text = articleText
        commentstableView.register(UINib(nibName: "ArticleCommentCell", bundle: nil), forCellReuseIdentifier: "ArticleCommentCell")        
        recommendeArticleTableView.register(UINib(nibName: "RecomendedArticleCell", bundle: nil), forCellReuseIdentifier: "RecomendedArticleCell")
        if !premiumStatus {
            addTextClosingView()
        } else {
            articleContentHeightConstraint.isActive = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        recommendeArticleTableView.separatorStyle = .none
        if tableView === commentstableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCommentCell", for: indexPath) as! ArticleCommentCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecomendedArticleCell", for: indexPath) as! RecomendedArticleCell
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func readComments() {
        
        self.dismiss(animated: true, completion: nil)
        delegate?.goToComments()
    }
    
    //Mark: go to back
    @IBAction func goToBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func share() {   // change button 
        
    }
    
    
    func addTextClosingView() {
        if let textClosingView = Bundle.main.loadNibNamed("TextClosingView", owner: self, options: nil)?.first as? TextClosingView {
            
           
            articleContentHeightConstraint.constant = 650
            articleContent.addSubview(textClosingView)
            textClosingView.textClosingViewDelegate = self // Delegate
            
            textClosingView.translatesAutoresizingMaskIntoConstraints = false
            textClosingView.topAnchor.constraint(equalTo: textClosingView.superview!.topAnchor, constant: 300).isActive = true
            textClosingView.bottomAnchor.constraint(equalTo: textClosingView.superview!.bottomAnchor, constant: 0).isActive = true
            textClosingView.leadingAnchor.constraint(equalTo: textClosingView.superview!.leadingAnchor, constant: 0).isActive = true
            textClosingView.trailingAnchor.constraint(equalTo: textClosingView.superview!.trailingAnchor, constant: 0).isActive = true
            
        }


    }
    
    //MARK: TextClosingView Delegate 
    func goToPremiumVC() {
           self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
           subscriptionDelegate?.goToSubscriptionVC()
       }
    
}
