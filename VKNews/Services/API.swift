//
//  API.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 19/10/2020.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.124"
    
    static let newsFeed = "/method/newsfeed.get"
    static let user = "/method/users.get"
}
