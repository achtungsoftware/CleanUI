//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

struct ViewPresentationWrapperPage<Content: View>: View {
    
    var name: String
    var description: String
    var viewToPresent: () -> Content
    
    init(_ name: String, description: String, @ViewBuilder viewToPresent: @escaping () -> Content) {
        self.name = name
        self.description = description
        self.viewToPresent = viewToPresent
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            viewToPresent()
            
            Spacer()
            
            Text(description)
                .foregroundColor(Color.grayText)
                .font(.caption)
        }
        .padding()
        .navigationBar(name)
    }
}
