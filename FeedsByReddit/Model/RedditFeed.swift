//
//  RedditFeed.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import Foundation

struct RedditFeed: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let author: String
    let subreddit: String
    let subreddit_name_prefixed: String
    let numComments: Int
    let created_utc: Date
    let thumbnail: String
    let score: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case author
        case subreddit = "subreddit"
        case subreddit_name_prefixed = "subreddit_name_prefixed"
        case numComments = "num_comments"
        case created_utc = "created_utc"
        case thumbnail = "thumbnail"
        case score = "score"

    }

    static func == (lhs: RedditFeed, rhs: RedditFeed) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}


extension RedditFeed {
    
    static func random() -> RedditFeed {
        return RedditFeed(id : randomString(maxLength: 30),
                         title: randomString(maxLength: 30),
                         author: randomString(maxLength: 30),
                         subreddit: randomString(maxLength: 30),
                         subreddit_name_prefixed: randomString(maxLength: 30),
                         numComments: randomInt(),
                         created_utc: randomDate(),
                         thumbnail:randomString(maxLength: 30),
                         score: randomInt())
    }
}
