//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// ``CLDateTime`` is an expandable date and time object which updates automatically
public struct CLDateTime: View {
    
    var timestamp: String
    var expandable: Bool
    var fixedFontSize: Bool
    var foregroundColor: Color
    var updateInterval: Int
    
    /// - Parameters:
    ///   - timestamp: A ISO8601 timestamp `String`
    ///   - expandable: Should it be expandable?, default is `true`
    ///   - fixedFontSize: Should it have a fixed font size? Or should the font size be automatic, so that it trys to fit everywhere?, default is `false`
    ///   - foregroundColor: The `foregroundColor`, default is `Color.grayText
    ///   - updateInterval: Define the interval in seconds in which the `CLDateTime` should be updated,
    ///   default is `5`. Set to `0` to disable updating.
    public init(_ timestamp: String, expandable: Bool = true, fixedFontSize: Bool = false, foregroundColor: Color = Color.grayText, updateInterval: Int = 5) {
        self.timestamp = timestamp
        self.expandable = expandable
        self.fixedFontSize = fixedFontSize
        self.foregroundColor = foregroundColor
        self.updateInterval = updateInterval
    }
    
    @State var showfullDateTime: Bool = false
    
    public var body: some View {
        Group {
            if updateInterval <= 0 {
                Text(showfullDateTime ? String(CUTime.timestampToHumanReadable(timestamp: CUTime.serverToLocalTime(dateStr: timestamp) ?? "") ?? "") :  CUTime.timestampStringToDate(timestamp: CUTime.serverToLocalTime(dateStr: timestamp) ?? "")?.timeAgo() ?? "")
                    .foregroundColor(foregroundColor)
                    .lineLimit(1)
                    .font(.caption2)
                    .if(!fixedFontSize) { view in
                        view.minimumScaleFactor(0.1)
                    }
                    .if(expandable) { view in
                        view.onTapGesture{
                            withAnimation {
                                showfullDateTime.toggle()
                            }
                        }
                    }
            }else {
                TimelineView(.periodic(from: Date.now, by: 5)) { _ in
                    Text(showfullDateTime ? String(CUTime.timestampToHumanReadable(timestamp: CUTime.serverToLocalTime(dateStr: timestamp) ?? "") ?? "") :  CUTime.timestampStringToDate(timestamp: CUTime.serverToLocalTime(dateStr: timestamp) ?? "")?.timeAgo() ?? "")
                        .foregroundColor(foregroundColor)
                        .lineLimit(1)
                        .font(.caption2)
                        .if(!fixedFontSize) { view in
                            view.minimumScaleFactor(0.1)
                        }
                        .if(expandable) { view in
                            view.onTapGesture{
                                withAnimation {
                                    showfullDateTime.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
}
