//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

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
