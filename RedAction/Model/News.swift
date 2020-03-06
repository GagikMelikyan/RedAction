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
    let excerpt: String
    let desc: String
    let featuredImgSrc: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case excerpt = "Excerpt"
        case desc = "Desc"
        case featuredImgSrc = "featured_img_src"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        excerpt = try container.decodeIfPresent(String.self, forKey: .excerpt) ?? ""
        featuredImgSrc = try container.decodeIfPresent(String.self, forKey: .featuredImgSrc) ?? ""
        desc = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    }
}
