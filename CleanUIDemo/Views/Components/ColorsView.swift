//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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
