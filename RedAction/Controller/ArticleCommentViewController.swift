//
//  ArticleCommentViewController.swift
//  RedAction
//
//  Created by User on 11/26/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class ArticleCommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleContent: UILabel!
    
    var article: Article?
    var articleImg: UIImage?
    var articleTitleText: String?
    var articleText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        navigationController?.navigationBar.isHidden = true
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: CommentTableViewCell.id)
        
        articleImageView.image = articleImg
        articleTitle.text = articleTitleText
        articleContent.text = articleText
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 10
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.id, for: indexPath) as! CommentTableViewCell
        return cell
       }
    
    //Mark: go to back
    @IBAction func goToBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
