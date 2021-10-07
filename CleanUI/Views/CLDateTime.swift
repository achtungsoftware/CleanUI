//
//  CLDateTime.swift
//  CleanUI
//
//  Created by Julian Gerhards on 06.10.21.
//

import SwiftUI

/// ``CLDateTime`` is an expandable date and time object which updates automatically
public struct CLDateTime: View {
    
    var timestamp: String
    var expandable: Bool
    
    /// - Parameters:
    ///   - timestamp: A ISO8601 timestamp String
    ///   - expandable: Should it be expandable?, default is true
    public init(_ timestamp: String, expandable: Bool = true) {
        self.timestamp = timestamp
        self.expandable = expandable
    }
    
    @State var showfullDateTime: Bool = false
    
    public var body: some View {
        TimelineView(.periodic(from: Date.now, by: 5)) { context in
            Text(showfullDateTime ? String(Time.timestampToHumanReadable(timestamp: Time.serverToLocalTime(dateStr: timestamp) ?? "") ?? "") :  Time.timestampStringToDate(timestamp: Time.serverToLocalTime(dateStr: timestamp) ?? "")?.timeAgo() ?? "")
                .foregroundColor(Color.grayText)
                .lineLimit(1)
                .font(.caption)
                .minimumScaleFactor(0.1)
                .if(expandable, transform: { view in
                    view.onTapGesture{
                        withAnimation {
                            showfullDateTime.toggle()
                        }
                    }
                })
        }
    }
}

/// ``CLBindingDateTime`` is the same as an ``CLDateTime`` except ``CLBindingDateTime`` uses a
/// Binding timestamp input for easy updates
public struct CLBindingDateTime: View {
    
    @Binding var timestamp: String
    var expandable: Bool
    
    /// - Parameters:
    ///   - timestamp: A binding ISO8601 timestamp String
    ///   - expandable: Should it be expandable?, default is true
    public init(_ timestamp: Binding<String>, expandable: Bool = true) {
        self._timestamp = timestamp
        self.expandable = expandable
    }
    
    @State var showfullDateTime: Bool = false
    
    public var body: some View {
        TimelineView(.periodic(from: Date.now, by: 5)) { context in
            Text(showfullDateTime ? String(Time.timestampToHumanReadable(timestamp: Time.serverToLocalTime(dateStr: timestamp) ?? "") ?? "") :  Time.timestampStringToDate(timestamp: Time.serverToLocalTime(dateStr: timestamp) ?? "")?.timeAgo() ?? "")
                .foregroundColor(Color.grayText)
                .lineLimit(1)
                .font(.caption)
                .minimumScaleFactor(0.1)
                .if(expandable, transform: { view in
                    view.onTapGesture{
                        withAnimation {
                            showfullDateTime.toggle()
                        }
                    }
                })
        }
    }
}

/// ``CLStaticDateTime`` is the same as an ``CLDateTime`` except ``CLStaticDateTime`` does not update
/// automatically
public struct CLStaticDateTime: View {
    
    var timestamp: String
    var expandable: Bool
    var fixedFontSize: Bool
    var foregroundColor: Color
    
    
    /// - Parameters:
    ///   - timestamp: A ISO8601 timestamp String
    ///   - expandable: Should it be expandable?, default is true
    ///   - fixedFontSize: Should it have a fixed font size? Or should the font size be automatic, so that it trys to fit everywhere?, default is false
    ///   - foregroundColor: The foregroundColor, default is Color.grayText
    public init(_ timestamp: String, expandable: Bool = true, fixedFontSize: Bool = false, foregroundColor: Color = Color.grayText) {
        self.timestamp = timestamp
        self.expandable = expandable
        self.fixedFontSize = fixedFontSize
        self.foregroundColor = foregroundColor
    }
    
    @State var showfullDateTime: Bool = false
    
    public var body: some View {
        Text(showfullDateTime ? String(Time.timestampToHumanReadable(timestamp: Time.serverToLocalTime(dateStr: timestamp) ?? "") ?? "") :  Time.timestampStringToDate(timestamp: Time.serverToLocalTime(dateStr: timestamp) ?? "")?.timeAgo() ?? "")
            .foregroundColor(foregroundColor)
            .lineLimit(1)
            .font(.caption)
            .if(!fixedFontSize, transform: { view in
                view.minimumScaleFactor(0.1)
            })
                .if(expandable, transform: { view in
                    view.onTapGesture{
                        withAnimation {
                            showfullDateTime.toggle()
                        }
                    }
                })
    }
}
