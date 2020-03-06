//
//  News.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 11/28/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import Foundation
import UIKit

struct News: Codable {
    let id: Int
    let title: String
    let desc: String
    let featuredImgSrc: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case desc = "Desc"
        case featuredImgSrc = "featured_img_src"
    }
}
