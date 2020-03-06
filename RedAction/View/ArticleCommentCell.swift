//
//  ArticleCommentCell.swift
//  RedAction
//
//  Created by User on 11/19/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import UIKit

class ArticleCommentCell: UITableViewCell {

    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



