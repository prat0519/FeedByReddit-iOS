//
//  RedditFeedListItemView.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import SwiftUI

struct RedditFeedListItemView: View {
    
    var feed: RedditFeed
    
    var body: some View {
        
        //set up the list item view -- Subreddit, Author name, Title, Image, MetaDataView(Score, Comment, Time)

        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .shadow(radius: 5, x: 3, y: 3)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(feed.subreddit).autocapitalization(UITextAutocapitalizationType.allCharacters).font(.headline)
                    Spacer()
                    
                    Text("By \(feed.author)")
                        .font(.caption)
                }.padding(.bottom)
                
            
                Text(feed.title)
                    .font(.headline)
                
                if feed.thumbnail != "self" && feed.thumbnail != "default" {
                    RedditFeedAsyncImage<Text>(
                        url: URL(string: feed.thumbnail)!,
                        placeholder: Text("Loading...")
                    ).aspectRatio(contentMode: .fit)
                }

                HStack {
                    RedditFeedMetaDataView(feed: feed)
                        .font(.caption)
                        .opacity(0.75)
                }.padding(.vertical)
                
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
        }
        .foregroundColor(.black)
        .padding(.horizontal, 10)
    }
}

struct RedditFeedListItemView_Previews: PreviewProvider {
    static var previews: some View {
        RedditFeedListItemView(feed: RedditFeed.random())
    }
}
