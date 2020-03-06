//
//  HomeScreenViewController.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/13/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func tapFunction()
}

private let homeIdentifier = "FeedCellHomeScreen"
private let monActuIdentifier = "FeedCellMonActu"
private let premiumIdentifier = "FeedCellPremium"
private let popularIdentifier = "FeedCellPopular"
var logo: UIImageView!
var blurEffectView: UIVisualEffectView!
var visualEffectView: UIVisualEffectView!

class HomeScreenViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CellDelegate {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        setUpCollectionView()
        setUpMenuBar()
        makeRightBarButtonItem()
        makeLeftBarButtonItem()
    }
    
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        showMenu()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if indexPath.item == 1 {
            guard let feedCellMonActu = collectionView.dequeueReusableCell(withReuseIdentifier: monActuIdentifier, for: indexPath) as? FeedCellMonActu else {
                fatalError("This cell is not an instance of FeedCellMonActu.")
            }
            
            feedCellMonActu.cellDelegate = self
            
            return feedCellMonActu
            
        } else if indexPath.item == 2 {
            guard let feedCellPremium = collectionView.dequeueReusableCell(withReuseIdentifier: premiumIdentifier, for: indexPath) as? FeedCellPremium else {
                fatalError("This cell is not an instance of FeedCellMonActu.")
            }
            
            feedCellPremium.cellDelegate = self
            
            return feedCellPremium
            
        } else if indexPath.item == 3 {
            guard let feedCellPopular = collectionView.dequeueReusableCell(withReuseIdentifier: popularIdentifier, for: indexPath) as? FeedCellPopular else {
                fatalError("This cell is not an instance of FeedCellMonActu.")
            }
            
            feedCellPopular.cellDelegate = self
            
            return feedCellPopular
        }
        
        guard let feedCellHome = collectionView.dequeueReusableCell(withReuseIdentifier: homeIdentifier, for: indexPath) as? FeedCellHomeScreen else {
            fatalError("This cell is not an instance of FeedCell.")
        }
        
        feedCellHome.cellDelegate = self
        
        return feedCellHome
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0

        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.bounds.size.height{
            case 480:
                height = view.frame.height
                print(height)
            case 568:
                height = view.frame.height
                print(height)
            case 667:
                height = view.frame.height
                print(height)
            case 736:
                height = view.frame.height - 10
                print(height)
            case 812:
                height = view.frame.height - 40
                print(height)
            case 896:
                height = view.frame.height - 40
                print(height)
            default:
                print(height)
            }
        }
               //return CGSize(width: view.frame.width, height: view.frame.height - 50)
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    private func makeRightBarButtonItem() {
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
    
    private func makeLeftBarButtonItem() {
        let btn = UIButton(type: .custom);
        btn.setImage(UIImage(named: "redaction-logo-mobile"), for: .normal);
        
        btn.frame = CGRect(x: 0, y: 0, width: 150, height: 30);
        let item = UIBarButtonItem(customView: btn);
        self.navigationItem.setLeftBarButtonItems([item], animated: false);
        
        item.customView?.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        item.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true;
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    // Make settings of menu bar
    private func setUpMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(40)]", views: menuBar)
    }
    
    // Make settings of collection view
    private func setUpCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
           //collectionView?.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        //   collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(40, 0, 0, 0)
        collectionView?.isPagingEnabled = true
        
    }
    
    // Make scroll function for collection view section
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    // Action for showing Menu
    private func showMenu () {
        
        let sideMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        self.definesPresentationContext = true
        sideMenuViewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(sideMenuViewController, animated: true, completion: nil)
        
    }
    
    // Click on label and push to View Controller
    func tapFunction() {
        let articleNVC = self.storyboard?.instantiateViewController(withIdentifier: "articleNavigationController") as! ArticleNavigationController
        let articleVC = articleNVC.viewControllers.first as! ArticleViewController
        let id = UserDefaults.standard.integer(forKey: "ArticleId")
        articleVC.articleId = id
        self.present(articleNVC, animated: true, completion: nil)
    }
    
}

