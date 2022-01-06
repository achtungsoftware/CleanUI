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
