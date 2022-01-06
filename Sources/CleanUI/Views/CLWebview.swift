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
import WebKit
import Combine

/// ``CLWebview`` is a UIViewRepresentable for an `WKWebView
public struct CLWebview: UIViewRepresentable {
    
    var url: URL
    @Binding var title: String
    @Binding var currentUrl: String
    
    /// - Parameters:
    ///   - url: The url that should be accessed
    ///   - title: The title of the current web page
    ///   - currentUrl: The url of the current web page
    public init(_ url: URL, title: Binding<String>, currentUrl: Binding<String>) {
        self.url = url
        self._title = title
        self._currentUrl = currentUrl
    }
    
    let webview = WKWebView()
    
    public func makeUIView(context: Context) -> WKWebView {
        webview.navigationDelegate = context.coordinator
        webview.allowsLinkPreview = true
        webview.allowsBackForwardNavigationGestures = true
        webview.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        webview.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        
        if(!url.absoluteString.lowercased().starts(with: String("https://")) && !url.absoluteString.lowercased().starts(with: String("http://"))){
            let request = URLRequest(url: URL(string: "http://" + url.absoluteString)!)
            webview.load(request)
        }else {
            let request = URLRequest(url: url)
            webview.load(request)
        }
        
        return webview
    }
    
    public func updateUIView(_ webview: WKWebView, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, WKNavigationDelegate {
        var parent: CLWebview
        
        init(_ webView: CLWebview) {
            self.parent = webView
        }
        
        public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "title" {
                withAnimation {
                    self.parent.title = parent.webview.title ?? "Browser"
                }
            }else if keyPath == "url" {
                withAnimation {
                    do {
                        self.parent.currentUrl = try String(contentsOf: parent.webview.url!)
                    }catch{}
                }
            }
        }
    }
}
