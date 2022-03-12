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

public struct PreviewContextMenuOverlay<Content: View, Target: View>: UIViewRepresentable {
    
    var content: Content
    var targetView: Target
    var menu: UIMenu?
    
    public init(content: Content, targetView: Target, menu: UIMenu?) {
        self.content = content
        self.targetView = targetView
        self.menu = menu
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let hostView = UIHostingController(rootView: content)
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor)
        ]
        
        view.addSubview(hostView.view)
        view.addConstraints(constraints)
        
        hostView.view.backgroundColor = .clear
        
        let interaction = UIContextMenuInteraction(delegate: context.coordinator)
        view.addInteraction(interaction)
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    public class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        
        var parent: PreviewContextMenuOverlay
        
        public init(_ parent: PreviewContextMenuOverlay) {
            self.parent = parent
        }
        
        public func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            return UIContextMenuConfiguration(identifier: nil) {
                let previewController = UIHostingController(rootView: self.parent.targetView)
                previewController.view.backgroundColor = UIColor.background
                return previewController
            } actionProvider: { items in
                return self.parent.menu
            }
        }
        
        public func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
            animator.addCompletion {
                if let viewController = animator.previewViewController {
                    if let navigationController = CUNavigation.getCurrentNavigationController() {
                        navigationController.show(viewController, sender: self)
                    }
                }
            }
        }
    }
}

public struct PreviewContextMenu<Content: View, Target: View>: View {
    
    var content: Content
    var targetView: Target
    var menu: UIMenu?
    
    public init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder targetView: @escaping () -> Target, menu: @escaping () -> UIMenu?) {
        self.content = content()
        self.targetView = targetView()
        self.menu = menu()
    }
    
    public var body: some View {
        content
            .opacity(0)
            .overlay(PreviewContextMenuOverlay(content: content, targetView: targetView, menu: menu))
    }
}

struct PreviewContextMenuOverlay_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                NavigationLink(destination: Text("Destination Page")) {
                    Text("Test Row")
                }
                .previewContextMenu {
                    Text("Destination Page")
                }
            }
        }
    }
}

public extension View {
    /// Adds a ``PreviewContextMenu`` to a `View`.
    /// - Parameters:
    ///   - targetView: Defines the target navigation and preview `View`
    ///   - menu: The `UIMenu` to show, can be `nil`, default is `nil`
    /// - Returns: The new PreviewContextMenu combined with the wrapped parent `View`
    func previewContextMenu<Preview: View>(@ViewBuilder targetView: @escaping () -> Preview, menu: @escaping () -> UIMenu? = {nil}) -> some View {
        return PreviewContextMenu(content: {self}, targetView: targetView, menu: menu)
    }
}
