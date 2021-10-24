//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

public extension Date {
    
    /// Converts a Date into an human readable String (1 hour, 5 days)
    /// - Returns: The human readable timestamp string
    func timeAgo() -> String {
        
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        let year = 12 * month
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = quotient == 1 ? CULanguage.getString("second") : CULanguage.getString("seconds")
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = quotient == 1 ? CULanguage.getString("minute") : CULanguage.getString("minutes")
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = quotient == 1 ? CULanguage.getString("hour") : CULanguage.getString("hours")
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = quotient == 1 ? CULanguage.getString("day") : CULanguage.getString("days")
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = quotient == 1 ? CULanguage.getString("week") : CULanguage.getString("weeks")
        } else if secondsAgo < year {
            quotient = secondsAgo / month
            unit = quotient == 1 ? CULanguage.getString("month") : CULanguage.getString("months")
        } else {
            quotient = secondsAgo / year
            unit = quotient == 1 ? CULanguage.getString("year") : CULanguage.getString("years")
        }
        return "\(quotient) \(unit)"
    }
}
