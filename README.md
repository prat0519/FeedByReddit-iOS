# Coding Assignment - FeedsByReddit

Project Name :-   FeedsByReddit

Given a 'listing' endpoint to the reddit API (https://www.reddit.com/.json), display a list of reddit feeds with the thumbnail and title. This list should be able to be infinite scrollable.


# Project Description


FeedByReddit is written with Swift 5.0 and Xcode 12.0.1

Technology Used
- uses swift 
- uses swiftUI for interface builing
- uses swift combine for network request

1.  Code Architecture (MVVM) :
   
   #List Screen :-
   
   List screen shows the all the feed retrieve through reddit client API. It shows all the details about the particular post like subreddit, author name, title, image. At the bottom of each item view, other meta data like comment, score and post time are shown.

   RedditFeedView is the root view to show content. RedditFeedListContainer communicated with the view model to load data. View model observe the data from Api services and update the model, also binds the data to view with help of RedditFeedListContainer to load list view. Each item in the list is drawn based on feeds array. 

   View model fetch the feeds with RedditFeedFetchable dependency. Network request and parsing are down with Combine framework using subscribers and publishers. For image loading, RedditFeedImageLoader is used. RedditFeedAsyncImage is the view to load image. It place a call to image loader on each item view and load downloaded images. 

   
2. UI Part: 

   All the UI is created with SwiftUI.

# Architecture
* MVVM (Modle-View-ViewModel)
* SwiftUI


# Requirements
* iOS 14.0
* Xcode 12.0.1
* Swift 5.0

# Data Source
* https://www.reddit.com/.json
* https://www.reddit.com/.json?after = + afterLink


# Dev Notes
* Would love to write unit test cases, but since the DataTaskPublisher is new and not simpler to mock so not much I can do in a short time.



    
