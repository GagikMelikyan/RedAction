//
//  SplashScreenViewController.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/9/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet var iconView: UIView!
    @IBOutlet var iconViewBottom: NSLayoutConstraint!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateView()
    }
    
    // Animation for UIView
    private func animateView() {
        self.iconViewBottom.constant = self.view.center.y - self.iconView.frame.size.height / 2
        UIView.animate(withDuration:1, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completion) in
            self.makeRootViewController()
        }
    }
    
    // Make Root View Controller
    private func makeRootViewController() {
        let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = testController
        appDelegate.window?.makeKeyAndVisible()
    }
    
}
