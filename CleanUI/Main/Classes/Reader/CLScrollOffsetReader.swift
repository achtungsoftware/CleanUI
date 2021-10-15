//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// This `UIViewControllerRepresentable` is able to find the first `UIScrollView`
/// in the `Content` view hierarchy. If a `UIScrollView` is found, it returns a scroll offset
public final class CLScrollOffsetReader<Content: View>: UIViewControllerRepresentable {
    
    let offsetChanged: (CGPoint) -> Void
    var content: () -> Content
    let subViewReaderHostingController: CUUIUScrollViewReaderHostingController<Content>
    
    /// - Parameters:
    ///   - offsetChanged: The offset changed callback
    ///   - content: The content to search in
    public init(offsetChanged: @escaping (CGPoint) -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.offsetChanged = offsetChanged
        self.content = content
        self.subViewReaderHostingController = CUUIUScrollViewReaderHostingController(offsetChanged: self.offsetChanged, content: self.content())
    }
    
    public func makeUIViewController(context: Context) -> CUUIUScrollViewReaderHostingController<Content> {
        return subViewReaderHostingController
    }
    
    public func updateUIViewController(_ uiViewController: CUUIUScrollViewReaderHostingController<Content>, context: Context) {
        
    }
}

/// This class is a `UIHostingController` wrapper which helps `CLScrollOffsetReader` finding a `UIScrollView`
public class CUUIUScrollViewReaderHostingController<Content: View>: UIHostingController<Content>{
    
    let offsetChanged: (CGPoint) -> Void
    var observer: NSKeyValueObservation?
    
    /// - Parameters:
    ///   - offsetChanged: The offset changed callback
    ///   - content: The content to search in
    public init(offsetChanged: @escaping (CGPoint) -> Void, content: Content) {
        self.offsetChanged = offsetChanged
        super.init(rootView: content)
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        observer = self.view.findFirstUISrollView?.observe(\.contentOffset, changeHandler: { scrollView, _ in
            self.offsetChanged(scrollView.contentOffset)
        })
    }
}
