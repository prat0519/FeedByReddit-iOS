//
//  RedditFeedView.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import SwiftUI

struct RedditFeedView: View {
    
    // MARK: - RedditFeedViewInput

    var body: some View {
        
        //Set up the navigation title and background color of root view
        NavigationView {
            RedditFeedListContainer()
                .navigationBarTitle("Feeds by Reddit")
                .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)).edgesIgnoringSafeArea([.all]))
        }
    }
}

struct RedditFeedView_Previews: PreviewProvider {
    static var previews: some View {
        RedditFeedView()
    }
}
