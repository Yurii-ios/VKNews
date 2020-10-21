//
//  FeedResponse.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 20/10/2020.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposrs: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
    
}
