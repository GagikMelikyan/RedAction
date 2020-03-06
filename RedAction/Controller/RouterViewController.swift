//
//  RouterViewController.swift
//  RedAction
//
//  Created by Ruzanna Sedrakyan on 11/18/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class RouterViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if UserDefaults.standard.bool(forKey: "firstUserConnected") {
            
            let accountController = mainStoryboard.instantiateViewController(withIdentifier: "AccountController") as! AccountController
            self.viewControllers = [accountController]
        } else {
            let loginController = mainStoryboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            self.viewControllers = [loginController]
        }
        
    }
    
}
