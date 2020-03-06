//
//  TextClosingView.swift
//  RedAction
//
//  Created by User on 12/13/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

protocol TextClosingViewDelegate: class {
    func goToPremiumVC()
}
class TextClosingView: UIView {

    weak var textClosingViewDelegate: TextClosingViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
  
    @IBAction func goToBuyPremium() {
        textClosingViewDelegate?.goToPremiumVC()
    }
    
}
