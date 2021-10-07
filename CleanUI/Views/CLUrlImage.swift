//
//  CLUrlImage.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// Returns an ``CLUrlImage`` which fetches a image from an url, displays and caches it, if needed
public struct CLUrlImage: View {
    
    @ObservedObject var urlImageModel: UrlImageModel
    var fallbackImage: UIImage?
    var contentMode: ContentMode
    
    /// - Parameters:
    ///   - urlString: The url string to the image
    ///   - fallbackImage: The fallback image, in case the url image could not be fetched
    ///   - aspectRatio: The contentMode, default is .fill
    public init(urlString: String?, fallbackImage: UIImage?, contentMode: ContentMode = .fill) {
        urlImageModel = UrlImageModel(urlString: urlString)
        self.contentMode = contentMode
        self.fallbackImage = fallbackImage ?? UIColor.accent.imageWithColor(width: 100, height: 100)
    }
    
    public var body: some View {
        Image(uiImage: ((urlImageModel.image ?? fallbackImage) ?? fallbackImage)!)
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}

public class UrlImageModel: ObservableObject {
    
    @Published public var image: UIImage?
    var urlString: String? = ""
    var imageCache = ImageCache.getImageCache()
    
    public init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    public func loadImage() {
        if self.loadImageFromCache() {
            return
        }
        self.loadImageFromUrl()
    }
    
    public func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        self.image = cacheImage
        
        return true
    }
    
    public func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
        
        if(!urlString.isEmpty){
            let url = URL(string: urlString)!
            let task = URLSession.shared.dataTask(with: url, completionHandler: self.getImageFromResponse(data:response:error:))
            task.resume()
        }
    }
    
    
    public func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            return
        }
        
        guard let data = data else {
            return
        }
        
        guard let loadedImage = UIImage(data: data) else {
            return
        }
        
        self.imageCache.set(forKey: self.urlString!, image: loadedImage)
        
        CUThreadHelper.async.main.run {
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
