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
import Combine
import SwiftPlus

public extension UIImage {
    
    /// Crops an UIImage from center with the given size
    /// - Parameters:
    ///   - size: The size frame for the new UIImage
    ///   - withOrientationFix: should the orientation be fixed?, default is false
    /// - Returns: The cropped `UIImage`
    func cropCenter(_ size: CGSize, withOrientationFix: Bool = false) -> UIImage {
        
        let cgimage: CGImage = withOrientationFix ? self.fixedOrientation().cgImage! : self.cgImage!
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        
        if size.width > size.height {
            posX = abs((contextSize.width - size.width) / 2)
            posY = 0
        } else {
            posY = abs((contextSize.height - size.height) / 2)
            posX = 0
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: size.width, height: size.height)
        
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
    
    
    /// Returns the aspect ratio for the given UIImage
    /// - Parameter roundTo: Round the aspect ratio x places after comma, default is 2
    /// - Returns: The aspect ratio
    func aspectRatio(_ roundTo: Int = 2) -> Double {
        let cgimage = self.fixedOrientation().cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var aspectRatio: Double
        if(contextSize.height > contextSize.width){
            aspectRatio = Double(contextSize.height/contextSize.width)
        }else {
            aspectRatio = Double(contextSize.width/contextSize.height)
        }
        
        return aspectRatio.round(to: roundTo)
    }
    
    
    /// Resizes an UIImage
    /// - Parameter newWidth: Set the new width, the height will get calculated
    /// - Returns: The resized UIImage
    func resize(newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    /// Merges 2 UIImages together
    /// - Parameter backgroundImage: The bottom UIImage
    /// - Returns: Both UIImages as one UIImage
    func mergeWith(backgroundImage: UIImage) -> UIImage {
        let topImage = self
        
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: topImage.size.width, height: topImage.size.height)
        topImage.draw(in: areaSize)
        
        backgroundImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        
        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
    
    /// Fixes the UIImage orientation. Could be used for upload, for example
    /// - Returns: The fixed UIImage
    func fixedOrientation() -> UIImage {
        
        if imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            break
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
            break
        case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
            break
        case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
            break
        @unknown default:
            break
        }
        
        switch imageOrientation {
        case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
            break
        @unknown default:
            break
        }
        
        let ctx: CGContext = CGContext(data: nil,
                                       width: Int(size.width),
                                       height: Int(size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent,
                                       bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        let cgImage: CGImage = ctx.makeImage()!
        
        return UIImage(cgImage: cgImage)
    }
}
