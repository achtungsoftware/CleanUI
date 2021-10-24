//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
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
        ForEach(menuItems, id: \.id) { item in
            if(item.show){
                Button(action: {
                    item.action()
                }, label: {
                    HStack(spacing: 16) {
                        if let icon = item.icon {
                            icon
                        }
                        
                        Text(item.title)
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    .contentShape(Rectangle())
                })
                    .buttonStyle(.plain)
                    .foregroundColor(item.foregroundColor != nil ? item.foregroundColor : Color.defaultText)
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
    }
}

