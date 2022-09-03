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

public struct CLFeedList<T: Model, UseApi: Api, RowView: View, LoadingView: View, NoDataView: View>: View {
    
    @ObservedObject var feedNetworking: CUFeedNetworking<T, UseApi>
    var row: (Binding<T>) -> RowView
    var loadingView: () -> LoadingView
    var noDataView: () -> NoDataView
    var listStyle: Style
    let startAtId: String?
    let refreshable: Bool
    let onDelete: ((_ offsets: IndexSet) -> Void)?
    
    public init(feedNetworking: CUFeedNetworking<T, UseApi>,
         @ViewBuilder row: @escaping (Binding<T>) -> RowView,
         @ViewBuilder loadingView: @escaping () -> LoadingView,
         @ViewBuilder noDataView: @escaping () -> NoDataView,
         listStyle: Style = .plain,
         startAtId: String? = nil,
         refreshable: Bool = true,
         onDelete: ((_ offsets: IndexSet) -> Void)? = nil) {
        self.feedNetworking = feedNetworking
        self.row = row
        self.loadingView = loadingView
        self.noDataView = noDataView
        self.listStyle = listStyle
        self.startAtId = startAtId
        self.refreshable = refreshable
        self.onDelete = onDelete
    }
    
    public var body: some View {
        ScrollViewReader { scrollViewReader in
            List {
                ForEach($feedNetworking.rows, id: \.id) { $user in
                    row($user)
                        .task {
                            await feedNetworking.rowDidAppear(user)
                        }
                }
                .onDelete(perform: onDelete)
                .onLoad {
                    if let startAtId = startAtId {
                        scrollViewReader.scrollTo(startAtId, anchor: .top)
                    }
                }
            }
            .if(refreshable) {
                $0.refreshable {
                    await feedNetworking.refresh()
                }
            }
            .if(listStyle == .plain) {
                $0.listStyle(.plain)
            }
            .if(listStyle == .inset) {
                $0.listStyle(.inset)
            }
            .if(listStyle == .grouped) {
                $0.listStyle(.grouped)
            }
            .if(listStyle == .insetGrouped) {
                $0.listStyle(.insetGrouped)
            }
        }
        .overlay(feedNetworking.isLoading ? loadingView() : nil)
        .overlay(feedNetworking.rows.isEmpty && !feedNetworking.isLoading ? noDataView() : nil)
    }
}

public extension CLFeedList {
    enum Style {
        case plain, inset, grouped, insetGrouped
    }
}
