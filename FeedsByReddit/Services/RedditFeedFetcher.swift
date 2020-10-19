//
//  RedditFeedFetcher.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import Foundation
import Combine

enum RedditFeedFetcherError: Error {
  case parsing(description: String)
  case network(description: String)
}

protocol RedditFeedFetchable {
    func posts(after: String?) -> AnyPublisher<RedditFeedResponse, RedditFeedFetcherError>
}

protocol RedditFeedURLComponentProtocol {
    func redditComponents(after: String?) -> URLComponents
}

class RedditFeedFetcher {
    
    // MARK: - Private implementation
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
}

// MARK: - Feeds Fetchable

extension RedditFeedFetcher: RedditFeedFetchable {
    
    func posts(after: String?) -> AnyPublisher<RedditFeedResponse, RedditFeedFetcherError> {
        guard let url = redditComponents(after: after).url else {
            return Fail(error: RedditFeedFetcherError.network(description: "Couldn't create URL")).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            self.decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
    
    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, RedditFeedFetcherError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
    
}

// MARK: -
// MARK: - Reddit API

extension RedditFeedFetcher : RedditFeedURLComponentProtocol {
    
    struct RedditApi {
        static let scheme = "https"
        static let host = "www.reddit.com"
        static let path = "/.json"
    }
    
    func redditComponents(after: String?) -> URLComponents {
        var components = URLComponents()
        components.scheme = RedditApi.scheme
        components.host = RedditApi.host
        components.path = RedditApi.path
        if let after = after {
            components.query = "&after=\(after)"
        }
        
        return components
    }
    
}
