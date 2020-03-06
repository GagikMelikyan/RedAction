//
//  User.swift
//  RedAction
//
//  Created by Ruzanna Sedrakyan on 8/29/19.
//  Copyright © 2019 Ruzanna Sedrakyan. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var first_name: String
    var last_name: String
    var email: String
    var password: String
    var username: String
    //var gender: String
    //var country: String
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        first_name = try container.decode(String.self, forKey: .first_name)
//        last_name = try container.decode(String.self, forKey: .last_name)
//        email = try container.decode(String.self, forKey: .email)
//        password = try container.decode(String.self, forKey: .password)
//        //gender = try container.decodeIfPresent(String.self, forKey: .gender) ?? ""
//        country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
//    }
    
}
