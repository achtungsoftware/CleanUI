//
//  Copyright © 2021 - present Julian Gerhards
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
                            
                            if index < menuItems.count - 1 {
                                Divider()
                            }
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

