//
//  Copyright © 2021 - present Julian Gerhards
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
        if secondsAgo < minute {
            quotient = secondsAgo
            return quotient == 1 ? CULanguage.getStringWithReplaceCleanUI("secondago", replace: "x@", with: String(quotient)) : CULanguage.getStringWithReplaceCleanUI("secondsago", replace: "x@", with: String(quotient))
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            return quotient == 1 ? CULanguage.getStringWithReplaceCleanUI("minuteago", replace: "x@", with: String(quotient)) : CULanguage.getStringWithReplaceCleanUI("minutesago", replace: "x@", with: String(quotient))
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            return quotient == 1 ? CULanguage.getStringWithReplaceCleanUI("hourago", replace: "x@", with: String(quotient)) : CULanguage.getStringWithReplaceCleanUI("hoursago", replace: "x@", with: String(quotient))
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            return quotient == 1 ? CULanguage.getStringWithReplaceCleanUI("dayago", replace: "x@", with: String(quotient)) : CULanguage.getStringWithReplaceCleanUI("daysago", replace: "x@", with: String(quotient))
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            return quotient == 1 ? CULanguage.getStringWithReplaceCleanUI("weekago", replace: "x@", with: String(quotient)) : CULanguage.getStringWithReplaceCleanUI("weeksago", replace: "x@", with: String(quotient))
        } else if secondsAgo < year {
            quotient = secondsAgo / month
            return quotient == 1 ? CULanguage.getStringWithReplaceCleanUI("monthago", replace: "x@", with: String(quotient)) : CULanguage.getStringWithReplaceCleanUI("monthsago", replace: "x@", with: String(quotient))
        } else {
            quotient = secondsAgo / year
            return quotient == 1 ? CULanguage.getStringWithReplaceCleanUI("yearago", replace: "x@", with: String(quotient)) : CULanguage.getStringWithReplaceCleanUI("yearsago", replace: "x@", with: String(quotient))
        }
    }
}
