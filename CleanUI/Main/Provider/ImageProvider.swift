//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// Provides images from the CleanUI frameworks Asset Catalog
class ImageProvider {
    
    /// Gets an image from the asset catalog
    /// - Parameter named: The image name
    /// - Returns: Image
    public static func image(_ named: String) -> Image {
        Image(named, bundle: Bundle(for: self))
    }
}
