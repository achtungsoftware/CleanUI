//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// This `UIViewControllerRepresentable` is able to find the first `UINavigationController`
/// in the `Content` view hierarchy. If a `UINavigationController` is found, it returns it
public final class CLUINavigationControllerReader<Content: View>: UIViewControllerRepresentable {
    
    let callback: (UINavigationController?) -> Void
    var content: () -> Content
    let subViewReaderHostingController: CUUINavigationControllerReaderHostingController<Content>
    
    /// - Parameters:
    ///   - callback: The callback with the optional `UINavigationController`
    ///   - content: The content to search in
    public init(callback: @escaping (UINavigationController?) -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.callback = callback
        self.subViewReaderHostingController = CUUINavigationControllerReaderHostingController(callback: callback, content: self.content())
    }
    
    public func makeUIViewController(context: Context) -> CUUINavigationControllerReaderHostingController<Content> {
        return subViewReaderHostingController
    }
    
    public func updateUIViewController(_ uiViewController: CUUINavigationControllerReaderHostingController<Content>, context: Context) {
        
    }
}

/// This class is a `UIHostingController` wrapper which helps `CLUINavigationControllerReader` finding a `UINavigationController`
public class CUUINavigationControllerReaderHostingController<Content: View>: UIHostingController<Content>{
    
    let callback: (UINavigationController?) -> Void
    
    /// - Parameters:
    ///   - callback: The callback with the optional `UINavigationController`
    ///   - content: The content to search in
    public init(callback: @escaping (UINavigationController?) -> Void, content: Content) {
        self.callback = callback
        super.init(rootView: content)
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        callback(self.findFirstUINavigationController)
    }
}
