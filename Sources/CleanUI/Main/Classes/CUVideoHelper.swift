//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import AVKit
import Combine
import SwiftPlus

public enum VideoExportQuality {
    case low
    case medium
    case high
    case extraHigh
    case ultra
}

public enum VideoOrientation {
    case up, down, right, left
}

/// This is a video helper class
public class CUVideoHelper {
    
    /// Gets the ``VideoOrientation`` for an video (AVAssetTrack)
    /// - Parameter track: The video (AVAssetTrack)
    /// - Returns: ``VideoOrientation``
    public static func orientation(for track: AVAssetTrack) -> VideoOrientation {
        let t = track.preferredTransform
        let size = track.naturalSize
        
        if(t.tx == 0 && t.ty == size.width) { // PortraitUpsideDown
            return .down
        } else if(t.tx == 0 && t.ty == 0) { // LandscapeRight
            return .right
        } else if(size.width == t.tx && size.height == t.ty) { // LandscapeLeft
            return .left
        } else {
            return .up
        }
    }
    
    /// Changes the ``VideoExportQuality`` for a video (URL)
    /// - Parameters:
    ///   - videoUrl: The video (URL)
    ///   - callback: The callback after finishing changing quality
    ///   - quality: ``VideoExportQuality``
    public static func changeQuality(videoUrl: URL, callback: @escaping ( _ newUrl: URL ) -> (), quality: VideoExportQuality = .medium) {
        let videoAsset = AVURLAsset(url: videoUrl, options: nil)
        
        let outputUrl = URL(fileURLWithPath: CUVideoHelper.getOutputPath(UUID().uuidString))
        
        let exporter = AVAssetExportSession(asset: videoAsset, presetName: quality.get())!
        exporter.outputURL = outputUrl
        exporter.outputFileType = AVFileType.mp4
        
        exporter.exportAsynchronously( completionHandler: { () -> Void in
            SPThreadHelper.async.main.run {
                callback( outputUrl )
            }
        })
    }
    
    /// Try's to get a thumbnail from an video (URL)
    /// - Parameters:
    ///   - url: The video (URL)
    ///   - completion: The callback with optional UIImage
    public static func getThumbnail(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        let asset = AVURLAsset(url: url, options: nil)
        let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        avAssetImageGenerator.appliesPreferredTrackTransform = true
        
        
        let thumnailTime = CMTimeMake(value: 0, timescale: 1)
        do {
            let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
            let thumbImage = UIImage(cgImage: cgThumbImage)
            SPThreadHelper.async.main.run {
                completion(thumbImage)
            }
        } catch {
            print(error.localizedDescription)
            SPThreadHelper.async.main.run {
                completion(nil)
            }
        }
    }
    
    /// Gets the size from an video (URL)
    /// - Parameter url: The video (URL)
    /// - Returns: The size (CGSize)
    public static func getSize(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
    
    public static func getOutputPath(_ name: String) -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true )[0] as NSString
        let outputPath = "\(documentPath)/\(name).mp4"
        return outputPath
    }
}
