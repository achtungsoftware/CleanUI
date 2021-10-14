//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// Returns the ``CLKnogglGradient`` a linear gradient in Knoggl style
public struct CLKnogglGradient: View {
    
    public init() {}
    
    public var body: some View {
        LinearGradient(colors: [
            Color(hex: "007BFF"),
            Color(hex: "007BFF"),
            Color(hex: "BD9C22"),
            Color(hex: "BD9C22"),
            Color(hex: "FE5643"),
            Color(hex: "FE5643")
        ], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
