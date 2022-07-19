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

/// This `View` is able to find the first `UIScrollView`
/// in the `Content` view hierarchy. If a `UIScrollView` is found, it returns a scroll offset, else nil
public struct CLScrollOffsetReader<Content: View>: View {
    
    let offsetChanged: (CGPoint?) -> Void
    var content: () -> Content
    
    /// - Parameters:
    ///   - offsetChanged: The offset changed callback
    ///   - content: The content to search in
    public init(offsetChanged: @escaping (CGPoint?) -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.offsetChanged = offsetChanged
        self.content = content
    }
    
    public var body: some View {
        content()
            .overlay(
                CUScrollOffsetReaderUIViewControllerRepresentable(offsetChanged: offsetChanged)
                    .frame(width: 0, height: 0)
                    .allowsHitTesting(false)
            )
    }
}

public struct CUScrollOffsetReaderUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let offsetChanged: (CGPoint?) -> Void
    let subViewReaderHostingController: CUScrollOffsetReaderUIViewController
    
    /// - Parameters:
    ///   - offsetChanged: The offset changed callback
    public init(offsetChanged: @escaping (CGPoint?) -> Void) {
        self.offsetChanged = offsetChanged
        self.subViewReaderHostingController = CUScrollOffsetReaderUIViewController(offsetChanged: self.offsetChanged)
    }
    
    public func makeUIViewController(context: Context) -> CUScrollOffsetReaderUIViewController {
        return subViewReaderHostingController
    }
    
    public func updateUIViewController(_ uiViewController: CUScrollOffsetReaderUIViewController, context: Context) {
        
    }
}

public class CUScrollOffsetReaderUIViewController: UIViewController {
    
    let offsetChanged: (CGPoint?) -> Void
    var observer: NSKeyValueObservation?
    
    /// - Parameters:
    ///   - offsetChanged: The offset changed callback
    public init(offsetChanged: @escaping (CGPoint?) -> Void) {
        self.offsetChanged = offsetChanged
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if observer == nil {
            
            let hostingView = self.view.findHostingView()
            let scrollView = hostingView?.findFirstUISrollView
            
            if hostingView == nil || scrollView == nil {
                self.offsetChanged(nil)
            }else {
                observer = scrollView?.observe(\.contentOffset, changeHandler: { scrollView, _ in
                    self.offsetChanged(scrollView.contentOffset)
                })
            }
        }
    }
    
    deinit {
        observer = nil
    }
}
