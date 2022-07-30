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

/// This is a time / Date helper class
public class CUTime {
    
    static let dateFormatter = DateFormatter()
    
    /// Converts seconds to a String like 03:46
    /// - Parameter seconds: The seconds
    /// - Returns: A String like 03:46
    public static func secondsToMinutesAndSecondsString(seconds : Int) -> String {
        let minutesF = (seconds % 3600) / 60
        let secondsF = (seconds % 3600) % 60
        return  "\(String(format: "%02d", minutesF)):\(String(format: "%02d", secondsF))"
    }
    
    /// Converts the user local time ISO8601 to server (UTC) ISO8601 time
    /// - Parameter dateStr: The ISO8601 timestamp String
    /// - Returns: The server (UTC)  ISO8601 timestamp String
    public static func localToServerTime(dateStr: String) -> String? {
        
        let timestamp = CUTime.verifiyDateTimeString(timestamp: dateStr)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: timestamp) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    /// Converts the server time (UTC) ISO8601 to user local time
    /// - Parameter dateStr: The (UTC)  ISO8601 timestamp String
    /// - Returns: The local ISO8601 timestamp String
    public static func serverToLocalTime(dateStr: String) -> String? {
        
        let timestamp = CUTime.verifiyDateTimeString(timestamp: dateStr)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: timestamp) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    
    /// Converts an ISO8601 timestamp String to a Date
    /// - Parameter timestamp: The ISO8601 timestamp String
    /// - Returns: The Date
    public static func timestampStringToDate(timestamp: String) -> Date? {
        
        let useTimestamp = CUTime.verifiyDateTimeString(timestamp: timestamp)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: useTimestamp) {
            return date
        }
        
        return nil
    }
    
    /// Converts an ISO8601 timestamp String to a human readable format like german: (Mittwoch, Sept. 29, 2021 05:23)
    /// - Parameter timestamp: The ISO8601 timestamp String
    /// - Returns: The human readable time format String
    public static func timestampToHumanReadable(timestamp: String) -> String? {
        
        let useTimestamp = CUTime.verifiyDateTimeString(timestamp: timestamp)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: useTimestamp) {
            dateFormatter.dateFormat = CULanguage.getString("dateformat")
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    public static func verifiyDateTimeString(timestamp: String) -> String {
        if timestamp.count == 19 {
            return timestamp.replacingOccurrences(of: " ", with: "T", options: .literal, range: nil)
        }else {
            return timestamp
        }
    }
}
