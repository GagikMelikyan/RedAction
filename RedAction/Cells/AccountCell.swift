//
//  AccountCell.swift
//  RedAction
//
//  Created by Ruzanna Sedrakyan on 11/20/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
