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

/// This is the main Sheet wrapper
internal struct CLSheet<Content: View>: View {
    
    var content: Content
    @StateObject private var viewModel: CLSheetViewModel = CLSheetViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if viewModel.showBackground {
                    Color.black
                        .opacity(0.20)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                }
                
                VStack(spacing: 0) {
                    Color.black
                        .opacity(0.001)
                        .onTapGesture {
                            viewModel.close()
                        }
                    
                    if viewModel.isShowing {
                        VStack(spacing: 0) {
                            HStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(.secondary)
                                    .frame(width: 35, height: 5, alignment: .center)
                                    .opacity(0.6)
                            }
                            .padding(.top, 5)
                            .padding(.bottom, 10)
                            
                            content
                            
                            Spacer()
                                .frame(width: geometry.size.width, height: geometry.safeAreaInsets.bottom + abs(viewModel.offset.height) / 4)
                        }
                        .transition(.move(edge: .bottom))
                        .frame(width: geometry.size.width)
                        .background(Color.alert)
                        .cornerRadius(12, corners: [.topLeft, .topRight])
                        .offset(x: 0, y: viewModel.offset.height > 0 ? viewModel.offset.height : 0)
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .highPriorityGesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged { gesture in
                        viewModel.offset = gesture.translation
                    }
                    .onEnded { g in
                        if viewModel.offset.height > 0 && abs(viewModel.offset.height) > 60 {
                            viewModel.close()
                        } else {
                            withAnimation(Animation.easeInOut(duration: 0.25)) {
                                viewModel.offset = .zero
                            }
                        }
                    }
            )
            .onLoad {
                viewModel.height = geometry.size.height
                viewModel.didLoad()
            }
        }
    }
}
