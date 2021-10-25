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

struct CLIconView: View {
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text(".textSize")
                HStack {
                    CLIcon(frameworkImage: "Back_Icon", size: .textSize)
                    CLIcon(frameworkImage: "Search_Icon", size: .textSize)
                    
                    CLIcon(systemImage: "clock", size: .textSize)
                    CLIcon(systemImage: "arrow.clockwise.icloud.fill", size: .textSize)
                }
                
                HStack {
                    CLIcon(frameworkImage: "Back_Icon", size: .textSize, newBadge: true)
                    CLIcon(frameworkImage: "Search_Icon", size: .textSize, newBadge: true)
                    
                    CLIcon(systemImage: "clock", size: .textSize, newBadge: true)
                    CLIcon(systemImage: "arrow.clockwise.icloud.fill", size: .textSize, newBadge: true)
                }
            }
            
            VStack {
                Text(".small")
                HStack {
                    CLIcon(frameworkImage: "Back_Icon", size: .small)
                    CLIcon(frameworkImage: "Search_Icon", size: .small)
                    
                    CLIcon(systemImage: "clock", size: .small)
                    CLIcon(systemImage: "arrow.clockwise.icloud.fill", size: .small)
                }
                
                HStack {
                    CLIcon(frameworkImage: "Back_Icon", size: .small, newBadge: true)
                    CLIcon(frameworkImage: "Search_Icon", size: .small, newBadge: true)
                    
                    CLIcon(systemImage: "clock", size: .small, newBadge: true)
                    CLIcon(systemImage: "arrow.clockwise.icloud.fill", size: .small, newBadge: true)
                }
            }
            
            VStack {
                Text(".medium")
                HStack {
                    CLIcon(frameworkImage: "Back_Icon", size: .medium)
                    CLIcon(frameworkImage: "Search_Icon", size: .medium)
                    
                    CLIcon(systemImage: "clock", size: .medium)
                    CLIcon(systemImage: "arrow.clockwise.icloud.fill", size: .medium)
                }
                
                HStack {
                    CLIcon(frameworkImage: "Back_Icon", size: .medium, newBadge: true)
                    CLIcon(frameworkImage: "Search_Icon", size: .medium, newBadge: true)
                    
                    CLIcon(systemImage: "clock", size: .medium, newBadge: true)
                    CLIcon(systemImage: "arrow.clockwise.icloud.fill", size: .medium, newBadge: true)
                }
            }
            
            VStack {
                Text(".large")
                HStack {
                    CLIcon(frameworkImage: "Back_Icon", size: .large)
                    CLIcon(frameworkImage: "Search_Icon", size: .large)
                    
                    CLIcon(systemImage: "clock", size: .large)
                    CLIcon(systemImage: "arrow.clockwise.icloud.fill", size: .large)
                }
                
                HStack {
                    CLIcon(frameworkImage: "Back_Icon", size: .large, newBadge: true)
                    CLIcon(frameworkImage: "Search_Icon", size: .large, newBadge: true)
                    
                    CLIcon(systemImage: "clock", size: .large, newBadge: true)
                    CLIcon(systemImage: "arrow.clockwise.icloud.fill", size: .large, newBadge: true)
                }
            }
        }
        
    }
}
