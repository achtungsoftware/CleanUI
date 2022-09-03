//  Copyright © 2021 - present Julian Gerhards
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// This class handles api feeds
/// `FeedNetworking` makes sure, that the `rows` array is unique with help of the `Identifiable` `id`
@MainActor open class CUFeedNetworking<T: Model, UseApi: Api>: ObservableObject {
    
    private var usePostRequests: Bool
    
    public init(usePostRequests: Bool = false) {
        self.usePostRequests = usePostRequests
    }
    
    /// This var stores the currently displayed rows
    @Published public var rows: Array<T> = []
    
    /// The api url should always be overwritten
    open var apiUrl: String { "" }
    
    /// The http post data
    open var postData: [String: String] { [:] }
    
    var loadMoreAtRowIndex: Int { 2 }
    
    /// This var stores the current page
    public var page: Int = 0
    
    /// This var indicates wether the first fetch is done.
    /// If this var is `true`, the first fetch is not done
    @Published public var isLoading: Bool = true
    
    /// This var indicates wether the network is currently fetching something
    public var isFetching: Bool = false
    
    /// This var indicates wether the network is currently refreshing the `rows`
    public var isRefreshing: Bool = false
    
    /// This var indicates wether the network is currently fetching more `rows`
    public var isFetchingMore: Bool = false
    
    /// This method fetches the first rows (page)
    /// - Parameters:
    ///   - animated: Should the result variables be animated?, default is `true`
    ///   - arrayMutation: Which ``ArrayMutationType`` should be used?, default is `.append`
    ///   - callback: The callback
    open func fetch(animated: Bool = true, arrayMutation: ArrayMutationType = .append, resetPage: Bool = false) async {
        
        if isFetching {
            return
        }
        
        if resetPage {
            page = 0
        }
        
        isFetching = true
        
        if let array = usePostRequests ? await UseApi.postObjectArray(apiUrl, parameters: paging(postData, _page: page), type: T.self) : await UseApi.getObjectArray(apiUrl, parameters: paging(postData, _page: page), type: T.self) {
            if animated {
                withAnimation {
                    switch arrayMutation {
                    case .replace:
                        self.rows = array
                    case .append:
                        for row in array {
                            if !self.contains(row) {
                                self.rows.append(row)
                            }
                        }
                    }
                }
            }else {
                switch arrayMutation {
                case .replace:
                    self.rows = array
                case .append:
                    for row in array {
                        if !self.contains(row) {
                            self.rows.append(row)
                        }
                    }
                }
            }
        }
        
        self.fetchFinished(animated: animated)
    }
    
    /// This method fetches more rows
    /// - Parameters:
    ///   - animated: Should the result variables be animated?, default is `true`
    ///   - callback: The callback
    open func fetchMore(animated: Bool = true) async {
        
        if isFetching || isFetchingMore {
            return
        }
        
        page += 1
        
        isFetchingMore = true
        
        await fetch(animated: animated)
        fetchMoreFinished(animated: animated)
    }
    
    /// This method refreshes and resets the rows to page `0`
    /// - Parameters:
    ///   - animated: Should the result variables be animated?, default is `true`
    ///   - callback: The callback
    open func refresh(animated: Bool = true) async {
        
        if isFetching {
            return
        }
        
        if animated {
            withAnimation {
                isRefreshing = true
            }
        }else {
            isRefreshing = true
        }
        
        page = 0
        
        await fetch(animated: animated, arrayMutation: .replace)
        refreshFinished(animated: animated)
    }
    
    /// This method must be called in `.task{}`, it automatically handles fetching more rows
    /// - Parameters:
    ///   - row: The loaded row `T`
    ///   - animated: Should the result variables be animated?, default is `true`
    public func rowDidAppear(_ row: T, animated: Bool = true) async {
        if !isFetchingMore && !isFetching && !isLoading {
            if CUStd.getArrayIndex(rows, searchedObject: row) == rows.count - loadMoreAtRowIndex {
                await fetchMore(animated: animated)
            }
        }
    }
    
    public func fetchFinished(animated: Bool = true) {
        
        isFetching = false
        
        if animated {
            withAnimation {
                isLoading = false
            }
        }else {
            isLoading = false
        }
    }
    
    public func fetchMoreFinished(animated: Bool = true) {
        if animated {
            withAnimation {
                isFetchingMore = false
            }
        }else {
            isFetchingMore = false
        }
    }
    
    public func refreshFinished(animated: Bool = true) {
        if animated {
            withAnimation {
                isRefreshing = false
            }
        }else {
            isRefreshing = false
        }
    }
    
    public func paging(_ params: [String : String], _page: Int) -> [String : String] {
        return params.merging([
            "page": String(_page)
        ]) { (_, new) in new }
    }
    
    
    /// Checks if the `rows` array contains the provided row `T`, with the help of the `Identifiable` `id`
    /// - Parameter row: The row to search for
    /// - Returns: `true` or `false`
    public func contains(_ row: T) -> Bool {
        for _row in rows {
            if _row.id == row.id {
                return true
            }
        }
        
        return false
    }
}

public extension CUFeedNetworking {
    enum ArrayMutationType {
        case replace, append
    }
}
