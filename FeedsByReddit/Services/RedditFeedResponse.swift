//
//  RedditFeedResponse.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import Foundation

struct FeedData: Codable {
    let data: RedditFeed
}

struct RedditFeedResponse: Codable {
        
    let after: String
    let feeds: [RedditFeed]
    
    enum CodingKeys: String, CodingKey {
        case after
        case feeds = "data"
        
        enum DataKeys: String, CodingKey {
            case after
            case children
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.DataKeys.self, forKey: .feeds)
        after = try dataContainer.decode(String.self, forKey: .after)
        let feedsData = try dataContainer.decode([FeedData].self, forKey: .children)
        feeds = feedsData.map { $0.data }
    }
}
