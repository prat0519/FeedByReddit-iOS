//
//  RedditFeedListView.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import SwiftUI

struct RedditFeedListView: View {

    let redditFeeds: [RedditFeed]
    let onScrolledAtEnd: () -> Void

    var body: some View {
        
        //Call the API to retrieve more feed once will get the after id or last feed
        
        List(redditFeeds) { feed in
            RedditFeedListItemView(feed: feed)
                .onAppear {
                    if feed == redditFeeds.last {
                        onScrolledAtEnd()
                    }
                }
        }
    }
}

