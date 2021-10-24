//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import AVKit
import Combine

public extension VideoExportQuality {
    func get()->String{
        switch self {
        case .low:
            return AVAssetExportPreset640x480
        case .medium:
            return AVAssetExportPreset960x540
        case .high:
            return AVAssetExportPreset1280x720
        case .extraHigh:
            return AVAssetExportPreset1920x1080
        case .ultra:
            return AVAssetExportPreset3840x2160
        }
    }
}
