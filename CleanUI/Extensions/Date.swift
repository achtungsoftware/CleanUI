//
//  Date.swift
//  CleanUI
//
//  Created by Julian Gerhards on 06.10.21.
//

import SwiftUI

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
            unit = quotient == 1 ? Language.getString("second") : Language.getString("seconds")
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = quotient == 1 ? Language.getString("minute") : Language.getString("minutes")
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = quotient == 1 ? Language.getString("hour") : Language.getString("hours")
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = quotient == 1 ? Language.getString("day") : Language.getString("days")
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = quotient == 1 ? Language.getString("week") : Language.getString("weeks")
        } else if secondsAgo < year {
            quotient = secondsAgo / month
            unit = quotient == 1 ? Language.getString("month") : Language.getString("months")
        } else {
            quotient = secondsAgo / year
            unit = quotient == 1 ? Language.getString("year") : Language.getString("years")
        }
        return "\(quotient) \(unit)"
    }
}
