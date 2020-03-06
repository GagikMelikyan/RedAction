//
//  Article.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 7/11/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import Foundation


struct Article: Codable {
    
    //MARK: Properties
    let id: Int
    let title: Title
    let content: Content
    let excerpt: Excerpt
    let embedded: Embedded
    let date_gmt: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, excerpt, date_gmt, date
        case embedded = "_embedded"
    }
}

// MARK: - Title
struct Title: Codable {
    let rendered: String
}

// MARK: - Content
struct Content: Codable {
    let rendered: String
}

// MARK: - Excerpt
struct Excerpt: Codable {
    let rendered: String
}

// MARK: - Embedded
struct Embedded: Codable {
    let wpFeaturedmedia: [WpFeaturedmedia]
    
    enum CodingKeys: String, CodingKey {
        case wpFeaturedmedia = "wp:featuredmedia"
    }
}

// MARK: - WpFeaturedmedia
struct WpFeaturedmedia: Codable {
    let sourceURL: String
    
    enum CodingKeys: String, CodingKey {
        case sourceURL = "source_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sourceURL = (try? container.decode(String.self, forKey: .sourceURL)) ?? "No sourceURL"
    }
}

struct ArticleDate: Codable {
    let date: String
}


