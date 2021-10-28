//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import CryptoKit
import Combine

public extension String {
    
    /// Trims a String
    /// - Returns: Trimmed String
    func trim(_ what: CharacterSet = .whitespacesAndNewlines) -> String {
        return self.trimmingCharacters(in: what)
    }
    
    /// Encodes a string for a URL Parameter
    /// - Returns: The encoded String
    func urlEncode() -> String {
        self.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
    }
    
    /// Get MD5 Hash from String
    var md5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
    
    /// Searches for Links in String
    /// - Returns: Dictionary of LinkString: NSRange
    func getLinks() -> [String: NSRange]{
        let types: NSTextCheckingResult.CheckingType = .link
        var links: [String: NSRange] = [:]
        do {
            let detector = try NSDataDetector(types: types.rawValue)
            let matches = detector.matches(in: self, options: .reportCompletion, range: NSMakeRange(0, self.utf16.count))
            for match in matches {
                links[NSString(string: self).substring(with: match.range) as String] = NSRange(location:match.range.location, length: match.range.length)
            }
            return links
        } catch {
            return [:]
        }
    }
    
    /// Searches for Hashtags in String
    /// - Returns: Dictionary of HashtagString: NSRange
    func getHashtags() -> [String: NSRange] {
        var hashtags:[String: NSRange] = [:]
        let regex = try? NSRegularExpression(pattern: "[#]\\w\\S*\\b", options: [])
        if let matches = regex?.matches(in: self, options:[], range: NSMakeRange(0, self.utf16.count)) {
            for match in matches {
                hashtags[NSString(string: self).substring(with: NSRange(location:match.range.location, length: match.range.length))] = NSRange(location:match.range.location, length: match.range.length)
            }
        }
        return hashtags
    }
    
    /// Searches for Mentions in String
    /// - Returns: Dictionary of MentionString: NSRange
    func getMentions() -> [String: NSRange] {
        var mentions:[String: NSRange] = [:]
        let regex = try? NSRegularExpression(pattern: "[@]\\w\\S*\\b", options: [])
        if let matches = regex?.matches(in: self, options:[], range: NSMakeRange(0, self.utf16.count)) {
            for match in matches {
                mentions[NSString(string: self).substring(with: NSRange(location:match.range.location, length: match.range.length))] = NSRange(location:match.range.location, length: match.range.length)
            }
        }
        return mentions
    }
}
