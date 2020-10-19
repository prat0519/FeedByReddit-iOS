//
//  RedditFeedMetaDataView.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import SwiftUI

struct RedditFeedMetaDataView: View {
    static let formatter = RelativeDateTimeFormatter()
    
    let feed: RedditFeed
    
    var body: some View {
        
        //Set up MetaDataView -- Score, Comment, Time

        HStack {
            Group {
                Image(systemName: "arrow.up")
                Text("\(feed.score)")
            }
            .foregroundColor(Color.green)
            
            Spacer()

            Group {
                Image(systemName: "text.bubble")
                Text("\(feed.numComments)")
            }
            .foregroundColor(Color.primary)
            
            Spacer()

            Group {
                Image(systemName: "clock")
                Text("\(Self.formatter.localizedString(for: feed.created_utc, relativeTo: Date()))")
            }
            .foregroundColor(Color.primary)
        }
    }
}

