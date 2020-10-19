//
//  RedditFeedImageLoader.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import Foundation
import SwiftUI
import Combine

class RedditFeedImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    // MARK: - Private property

    private let url: URL
    private var cancellable: AnyCancellable?
    
    // MARK: - Lifecycle method

    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    // MARK: - Public method

    func loadImage() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
