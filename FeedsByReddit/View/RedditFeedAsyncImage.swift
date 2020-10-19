//
//  RedditFeedAsyncImage.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import SwiftUI
import Combine
import Foundation

struct RedditFeedAsyncImage<Placeholder: View>: View {
    
    @StateObject private var loader: RedditFeedImageLoader
    private let placeholder: Placeholder
    
    init(url: URL, placeholder: Placeholder) {
        self.placeholder = placeholder
        _loader = StateObject(wrappedValue: RedditFeedImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.loadImage)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

