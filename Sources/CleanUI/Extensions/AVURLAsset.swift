//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import AVKit
import Combine
import SwiftPlus

public extension AVURLAsset {
    
    /// Converts degrees to radians
    /// - Parameter number: Degrees number
    /// - Returns: The converted number
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    /// Crops, resizes, fixes orientation, limiting length, changing quality and converting to MP4
    /// - Parameters:
    ///   - index: ?
    ///   - cropRect: The rectangle to crop
    ///   - callback: The callback after everthing is done
    ///   - quality: The quality ``VideoExportQuality``
    ///   - maxLength: The max length in seconds
    func cropResizeFixCutAndConvertToMP4(at index: Int, cropRect: CGRect, callback: @escaping ( _ newUrl: URL ) -> (), quality: VideoExportQuality, maxLength: Double) {
        
        let videoTrack = tracks(withMediaType: .video)[index]
        let trackOrientation = CUVideoHelper.orientation(for: videoTrack)
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = cropRect.size
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
        
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRange(start: .zero, duration: CMTime(seconds: 60, preferredTimescale: 30))
        
        let cropOffX: CGFloat = cropRect.origin.x
        let cropOffY: CGFloat = cropRect.origin.y
        
        let transformer = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        
        var finalTransform: CGAffineTransform = CGAffineTransform.identity // setup a transform that grows the video, effectively causing a crop
        
        switch trackOrientation {
        case .up:
            finalTransform = finalTransform
                .translatedBy(x: videoTrack.naturalSize.height - cropOffX, y: 0 - cropOffY)
                .rotated(by: CGFloat(deg2rad(90.0)))
        case .down:
            finalTransform = finalTransform
                .translatedBy(x: 0 - cropOffX, y: videoTrack.naturalSize.width - cropOffY)
                .rotated(by: CGFloat(deg2rad(-90.0)))
        case .right:
            finalTransform = finalTransform.translatedBy(x: 0 - cropOffX, y: 0 - cropOffY )
        case .left:
            finalTransform = finalTransform
                .translatedBy(x: videoTrack.naturalSize.width - cropOffX, y: videoTrack.naturalSize.height - cropOffY )
                .rotated(by: CGFloat(deg2rad(-180.0)))
        }
        
        transformer.setTransform(finalTransform, at: .zero)
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]
        
        let croppedOutputFileUrl = URL(fileURLWithPath: CUVideoHelper.getOutputPath(UUID().uuidString))
        
        let exporter = AVAssetExportSession(asset: self, presetName: quality.get())!
        exporter.videoComposition = videoComposition
        exporter.outputURL = croppedOutputFileUrl
        exporter.outputFileType = AVFileType.mp4
        
        
        // Limit video length
        let startTime = CMTime(seconds: Double(0), preferredTimescale: 1000)
        
        var endTime: CMTime
        if(self.duration.seconds > maxLength){
            endTime = CMTime(seconds: maxLength, preferredTimescale: 1000)
        }else {
            endTime = CMTime(seconds: Double(self.duration.seconds), preferredTimescale: 1000)
        }
        let timeRange = CMTimeRange(start: startTime, end: endTime)
        
        exporter.timeRange = timeRange
        
        exporter.exportAsynchronously( completionHandler: { () -> Void in
            SPThreadHelper.async.main.run {
                callback( croppedOutputFileUrl )
            }
        })
    }
}
