//
//  SubscriptionViewController.swift
//  RedAction
//
//  Created by User on 11/30/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    //Mark: Outlets
    @IBOutlet weak var monthSubscriptionView: UIView!
    @IBOutlet weak var yearSubscriptionView: UIView!

    var selected = "year"
    
    let activeColor = UIColor(red: 233.0/255, green: 181.0/255, blue: 39.0/255, alpha: 1)
    let inactiveColor = UIColor(red: 221.0/255, green: 221.0/255, blue: 221.0/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthSubscriptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectMonth)))
        yearSubscriptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectYear)))
    }

    @objc func selectMonth() {
        monthSubscriptionView.backgroundColor = activeColor
        yearSubscriptionView.backgroundColor = inactiveColor
        selected = "month"
    }
    
    @objc func selectYear() {
        monthSubscriptionView.backgroundColor = inactiveColor
        yearSubscriptionView.backgroundColor = activeColor
        selected = "year"
    }
    
      
}
