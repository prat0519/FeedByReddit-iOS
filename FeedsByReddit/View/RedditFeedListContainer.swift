//
//  RedditFeedListContainer.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import SwiftUI

struct RedditFeedListContainer: View {
    

    @StateObject var viewModel: RedditFeedListViewModel

    init() {
        _viewModel = .init(wrappedValue: RedditFeedListViewModel(apiService: RedditFeedFetcher()))
    }
    
    var body: some View {
        
        // MARK: - RedditFeedViewOutput

        //Load spinner if no data is there and load the feeds from API -- Draw the list view
        Group{
            if viewModel.redditFeeds.isEmpty {
                spinner
            } else {
                list
            }
        }
        .onAppear(perform: viewModel.fetchFeeds)
    }
    
    var list: some View {
        RedditFeedListView(
            redditFeeds: viewModel.redditFeeds,
            onScrolledAtEnd: viewModel.fetchFeeds
        )
    }
    
    var spinner: some View {
        Spinner(style: .medium)
    }
   
}

struct RedditFeedListContainer_Previews: PreviewProvider {
    static var previews: some View {
        RedditFeedListContainer()
    }
}
