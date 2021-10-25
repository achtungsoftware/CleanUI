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
import Combine

/// This class handles browser windows
public class CUBrowser {
    
    /// Opens a new browser window / sheet
    /// - Parameters:
    ///   - urlString: The initial url as `String`
    public static func open(_ urlString: String){
        if let url = URL(string: urlString){
            CUNavigation.pushBottomSheet(CLBrowserView(url: url))
        }
    }
}

struct CLBrowserView: View {
    
    let url: URL
    @State private var title: String = ""
    @State private var currentUrl: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                CLWebview(url, title: $title, currentUrl: $currentUrl)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        UIApplication.shared.open(url)
                    }){
                        Image(systemName: "safari")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text(CULanguage.getStringCleanUI("close"))
                    }
                }
            }
        }
    }
}
