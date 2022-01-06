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

/// This is the main Alert wrapper
internal struct CLALert<Content: View>: View {
    
    var content: Content
    @StateObject private var viewModel: CLAlertViewModel = CLAlertViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isShowing {
                Color.black
                    .opacity(0.20)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .onTapGesture {
                        viewModel.close()
                    }
                
                VStack(spacing: 0) {
                    content
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.alert)
                )
                .padding()
            }
        }
        .onLoad {
            viewModel.didLoad()
        }
    }
}
