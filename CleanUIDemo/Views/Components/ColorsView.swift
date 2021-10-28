//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import CleanUI

struct ColorsView: View {
    var body: some View {
        VStack {
            ZStack {
                Color.accent
                Text("Color.accent")
            }
            ZStack {
                Color.accent2
                Text("Color.accent2")
            }
            ZStack {
                Color.accent3
                Text("Color.accent3")
            }
            ZStack {
                Color.accent4
                Text("Color.accent4")
            }
            ZStack {
                Color.defaultText
                Text("Color.defaultText")
            }
            ZStack {
                Color.grayText
                Text("Color.grayText")
            }
            
            Group {
                ZStack {
                    Color.link
                    Text("Color.link")
                }
                ZStack {
                    Color.defaultRed
                    Text("Color.defaultRed")
                }
                ZStack {
                    Color.background
                    Text("Color.background")
                }
                ZStack {
                    Color.primaryColor
                    Text("Color.primaryColor")
                }
                ZStack {
                    Color.accentStaticDark
                    Text("Color.accentStaticDark")
                }
                ZStack {
                    Color.defaultBorder
                    Text("Color.defaultBorder")
                }
            }
        }
        .foregroundColor(.secondary)
        .navigationBar("Colors")
    }
}
