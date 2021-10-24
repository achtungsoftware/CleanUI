//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
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
                    .opacity(0.25)
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
                    RoundedRectangle(cornerRadius: 16)
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
