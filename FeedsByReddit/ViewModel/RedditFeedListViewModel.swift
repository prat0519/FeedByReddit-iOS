//
//  RedditFeedListViewModel.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import Combine
import SwiftUI

class RedditFeedListViewModel: ObservableObject {
    
    @Published var redditFeeds = [RedditFeed]()
    var after : String?
    
    // MARK: - Private properties
    
    private var disposables = Set<AnyCancellable>()
    private var cancellable: AnyCancellable?
    private var feeds: [RedditFeed] = []
    
    private var isFetching = false
    private (set) var hasMoreData = true
    
    private var apiService: RedditFeedFetchable

    // MARK: - Lifecycle method

    init(apiService: RedditFeedFetchable) {
        //inject dependency through initiliazer
        self.apiService = apiService
    }
    
    // MARK: - Update Feeds

    func updateFeeds(with feeds: [RedditFeed]){
        self.redditFeeds.append(contentsOf: feeds)
    }

    // MARK: - Public method

    func fetchFeeds() {

        guard !isFetching && hasMoreData else {
            return
        }
        self.isFetching = true
        
        self.apiService.posts(after: after)
                .receive(on: DispatchQueue.main)
                     .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else {
                    return
                }
                self.isFetching = false
                switch completion {
                case .failure(let error):
                    print("Failed to laod feeds -- \(error.localizedDescription)") 
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] response in
                guard let self = self else {
                    return
                }
                self.isFetching = false
                self.updateViewModel(from: response)
            }
        )
        .store(in: &disposables)
    }
    
    // MARK: - Private implementation
    
    private func updateViewModel(from response: RedditFeedResponse) {

        self.after = response.after
        self.updateFeeds(with: response.feeds.map({ (feed) -> RedditFeed in
            return RedditFeed(id: feed.id,
                              title: feed.title,
                              author: feed.author,
                              subreddit: feed.subreddit,
                              subreddit_name_prefixed: feed.subreddit_name_prefixed,
                              numComments : feed.numComments,
                              created_utc: feed.created_utc,
                              thumbnail: feed.thumbnail,
                              score: feed.score)
        }))
    }
}

