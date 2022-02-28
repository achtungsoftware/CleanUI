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
import Combine


/// Returns a styled menu for ``CUSheet``
public struct CLSheetMenu: View {
    
    var menuItems: [CLSheetMenuItem]
    
    /// - Parameter menuItems: The ``CLSheetMenuItem`` array
    public init(_ menuItems: [CLSheetMenuItem]) {
        self.menuItems = menuItems
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(menuItems.enumerated()), id: \.offset) { index, item in
                if item.show {
                    Button(action: {
                        item.action()
                    }) {
                        VStack(spacing: 0) {
                            HStack(spacing: 16) {
                                if let icon = item.icon {
                                    icon
                                }
                                
                                Text(item.title)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 16)
                            .padding(.top, 16)
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(MenuButtonStyle())
                    .foregroundColor(item.foregroundColor != nil ? item.foregroundColor : Color.defaultText)
                    .font(.callout)
                }
            }
        }
    }
}

