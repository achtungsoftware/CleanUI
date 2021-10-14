//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

public extension Image {
    
    /// Allowes the init with an default image
    /// - Parameters:
    ///   - name: The image name
    ///   - defaultImage: The default image name
    init(_ name: String, defaultImage: String) {
        if let img = UIImage(named: name) {
            self.init(uiImage: img)
        } else {
            self.init(defaultImage)
        }
    }
    
    /// Allowes the init with an default system image
    /// - Parameters:
    ///   - name: The system image name
    ///   - defaultImage: The default system image name
    init(_ name: String, defaultSystemImage: String) {
        if let img = UIImage(named: name) {
            self.init(uiImage: img)
        } else {
            self.init(systemName: defaultSystemImage)
        }
    }
}
