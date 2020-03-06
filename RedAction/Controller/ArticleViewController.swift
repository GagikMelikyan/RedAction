//
//  ArticleViewController.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/25/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//



// DELETE THIS CONTROLLOER IN THE END


import UIKit

private let reuseIdentifier = "ArticleCell"
var data = [Article]()

class ArticleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var backBtn: UIButton!
    
    var articleId: Int?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
//        UIApplication.shared.statusBarStyle = .default
//        self.backBtn = UIButton(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
//        backBtn.backgroundColor = .clear
//        backBtn.setImage(UIImage(named: "left-arrow-angle"), for: .normal)
//        backBtn.addTarget(self, action: #selector(goBackBtn), for: .touchUpInside)
//        self.backBtnView.addSubview(backBtn)
        
//        self.backBtnView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
//        backBtnView.backgroundColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 0.9)
//        self.backBtnView.addSubview(backBtn)
//        self.view.addSubview(backBtnView)
        
        setUpNavigationBarItems()
        setUpCollectionView()
        getArticle()
    }
    
    @objc func goBackBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionGoBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    // Make share action
    

        @IBAction func actionShare(_ sender: UIBarButtonItem) {
    
            //Set the default sharing message.
            let message = "Message goes here."
            //Set the link to share.
            if let link = NSURL(string: "http://yoururl.com")
            {
                let objectsToShare = [message,link] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.excludedActivityTypes = [UIActivityType.airDrop,
                                                    UIActivityType.addToReadingList,
                                                    UIActivityType.postToWeibo,
                                                    UIActivityType.print,
                                                    UIActivityType.assignToContact,
                                                    UIActivityType.saveToCameraRoll,
                                                    UIActivityType.addToReadingList,
                                                    UIActivityType.postToFlickr,
                                                    UIActivityType.postToVimeo,
                                                    UIActivityType.postToTencentWeibo]
                self.present(activityVC, animated: true, completion: nil)
            }
            
//            //let objectsToShare:URL = URL(string: "http://www.google.com")!
//            //let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,textLabelText as AnyObject]
//            //let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
//            let activityViewController = UIActivityViewController(activityItems : [textLabelText], applicationActivities: nil)
//            //activityViewController.popoverPresentationController?.sourceView = self.view
//            present(activityViewController, animated: true, completion: nil)
        }
    
    // MARK: UICollectionViewDataSource
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return 1
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ArticleViewCell else {
            fatalError("This cell is not an instance of ArticleViewCell.")
        }
        
//        let imageUrl = data[indexPath.item].embedded.wpFeaturedmedia[0].sourceURL
//        let url = URL(string: imageUrl) ?? URL(string: "")
//        cell.articleImage.load(url: url!)
        
//        cell.titleLabel.text = data[indexPath.item].title.rendered.htmlToString
//        cell.textLabel.text = data[indexPath.item].content.rendered.htmlToString
        cell.configureArticleCell(data[indexPath.item].content.rendered.htmlToString)
//        cell.textLabel.sizeToFit()
        
        
        
        return cell
    }
    
    // Make settings of navigation bar
    private func setUpNavigationBarItems() {
//        makeLeftBarButtonItem()
        makeRightBarButtonItem()
    }
    
    fileprivate func makeRightBarButtonItem() {
        let sortButton = UIButton(frame: CGRect(x: 0, y: 0, width: 110, height: 25))
        sortButton.setTitle("FAIRE UN DON", for: .normal)
        sortButton.titleLabel?.font = UIFont(name: "Calibri", size: 15)
        sortButton.setTitleColor(.white, for: .normal)
        sortButton.layer.cornerRadius = 5
        sortButton.backgroundColor = UIColor (red: 232/255.0, green: 181/255.0, blue: 40/255.0, alpha: 1)
        let item = UIBarButtonItem(customView: sortButton);
        self.navigationItem.setRightBarButtonItems([item], animated: false);
        item.customView?.widthAnchor.constraint(equalToConstant: 110).isActive = true;
        item.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func makeLeftBarButtonItem() {
        let btn = UIButton(type: .custom);
        btn.setImage(UIImage(named: "redaction-logo-mobile"), for: .normal);
        
        btn.frame = CGRect(x: 0, y: 0, width: 150, height: 30);
        let item = UIBarButtonItem(customView: btn);
        self.navigationItem.setLeftBarButtonItems([item], animated: false);
        
        item.customView?.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        item.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true;
    }
    
    // Make settings of collection view
    private func setUpCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = collectionView {
            let w = collectionView.frame.width
            flowLayout.estimatedItemSize = CGSize(width: w, height: 404)
        }
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
            
            data.removeAll()
            data.append(article)
            
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
            })
        }
    }
    
}
