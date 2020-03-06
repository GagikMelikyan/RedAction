//
//  ArticlesListViewController.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/13/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class ArticlesListViewController: UIViewController {
    
    @IBOutlet var buttonALaUne: UIButton!
    @IBOutlet var buttonMonActu: UIButton!
    @IBOutlet var buttonPremium: UIButton!
    @IBOutlet var buttonPopulaires: UIButton!
    
    var lineView: UIView!
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        makeNavigationBarTitle()
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setLayoutSubviews()
    }
    
    
    @IBAction func didTapALaUneButton(_ sender: UIButton) {
        addButtonBottomBorder(button: buttonALaUne)
    }
    @IBAction func didTapMonActuButton(_ sender: UIButton) {
    }
    @IBAction func didTapPremiumButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapPopulairesButton(_ sender: UIButton) {
    }
    // Make navigation bar title as image view
    private func makeNavigationBarTitle() {
        let logo = UIImage(named: "Redaction white logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    private func setLayoutSubviews() {
    
       addButtonBottomBorder(button: buttonALaUne)
        //addButtonBottomBorder(button: buttonMonActu)
        //addButtonBottomBorder(button: buttonPremium)
        //addButtonBottomBorder(button: buttonPopulaires)
    }
    private func addButtonBottomBorder(button: UIButton) {
        lineView = UIView(frame: CGRect(x: 0, y: button.frame.size.height, width: button.frame.size.width, height: 2))
        lineView.backgroundColor = UIColor.black
        button.addSubview(lineView!)
    }
    
    private func removeButtonBottomBorder (button: UIButton) {
        lineView.isHidden = true
    }

}


