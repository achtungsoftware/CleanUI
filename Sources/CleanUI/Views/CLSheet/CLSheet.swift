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
    @StateObject private var model: ViewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if model.showBackground {
                    Color.black
                        .opacity(0.20)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                }
                
                VStack(spacing: 0) {
                    Color.black
                        .opacity(0.001)
                        .onTapGesture {
                            model.close()
                        }
                    
                    if model.isShowing {
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
                                .frame(width: geometry.size.width.maxValue(500), height: geometry.safeAreaInsets.bottom + abs(model.offset.height) / 4)
                        }
                        .transition(.move(edge: .bottom))
                        .frame(width: geometry.size.width.maxValue(500))
                        .background(Color.alert)
                        .cornerRadius(12, corners: [.topLeft, .topRight])
                        .offset(x: 0, y: model.offset.height > 0 ? model.offset.height : 0)
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .highPriorityGesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged { gesture in
                        model.offset = gesture.translation
                    }
                    .onEnded { g in
                        if model.offset.height > 0 && abs(model.offset.height) > 60 {
                            model.close()
                        } else {
                            withAnimation(Animation.easeInOut(duration: 0.25)) {
                                model.offset = .zero
                            }
                        }
                    }
            )
            .onLoad {
                model.height = geometry.size.height
                model.didLoad()
            }
        }
    }
}

internal extension CLSheet {
    class ViewModel: ObservableObject {
        
        @Published var isShowing: Bool = false
        @Published var showBackground: Bool = false
        @Published var offset = CGSize.zero
        @Published var height: CGFloat = 0
        
        func didLoad() {
            
            // Show the sheet with animation
            withAnimation(Animation.interpolatingSpring(mass: 0.2, stiffness: 29.5, damping: 12, initialVelocity: 10)){
                isShowing = true
                showBackground = true
            }
        }
        
        /// Closes / dismisses the sheet
        func close() {
            withAnimation(Animation.easeInOut(duration: 0.25)) {
                offset.height = height
                showBackground = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                CUSheet.clearAll()
            }
        }
    }
}
