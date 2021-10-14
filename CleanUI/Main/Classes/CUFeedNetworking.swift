//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// This is the base class for a feed (networking). It handles pagination and holds properties
/// which can be used to get information about the current feed
open class CUFeedNetworking: ObservableObject {
    
    public init() {}
    
    /// This var is indicating whether the networking is currently fetching
    @Published public var isFetching: Bool = false
    
    /// This var is indicating whether the networking is currently loading
    /// for the first time. After ``FeedNetworking/initialFetch``
    /// is finished, this var should be set to false and should never change again
    @Published public var isLoading: Bool = true
    
    /// This var is indicating whether the networking is currently fetching more
    @Published public var isFetchingMore: Bool = false
    
    /// This var indicates the current pagination page for the http request
    @Published public var page: Int = 0
    
    /// This method should be used for the initial fetch request
    open func initialFetch() {
        isFetching = true
    }
    
    /// This method should be used for fetch more requests
    open func fetchMore() {
        isFetching = true
        withAnimation {
            isFetchingMore = true
        }
        page += 1
    }
    
    /// This method should be used for refreshing
    /// - Parameters:
    ///   - withPageReset: In nearly all cases, this variable should be `true`, if set to false the `page` var does not
    ///   get a reset
    ///   - finished: The finished callback function
    open func refresh(withPageReset: Bool, finished: @escaping () -> Void) {
        isFetching = true
        if withPageReset {
            page = 0
        }
    }
    
    /// This method should be called when ``CUFeedNetworking/initialFetch``
    /// is finished
    public func initialFetchFinished() {
        isFetching = false
        withAnimation {
            isLoading = false
        }
    }
    
    /// This method should be called when ``CUFeedNetworking/fetchMore``
    /// is finished
    public func fetchMoreFinished() {
        isFetching = false
        withAnimation {
            isFetchingMore = false
        }
    }
    
    /// This method should be called when ``CUFeedNetworking/refresh``
    /// is finished
    public func refreshFinished() {
        isFetching = false
    }
}
