//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

extension ImageCache {
    private static var imageCache = ImageCache()
    
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
