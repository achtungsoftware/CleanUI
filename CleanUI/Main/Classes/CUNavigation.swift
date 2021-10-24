//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// This class handles all sorts of programmatic navigation
public class CUNavigation {
    
    public enum BottomSheetSize {
        case halfDontAllowFull
        case fullDontAllowHalf
        case fullAllowHalf
        case halfAllowFull
    }
    
    /// Trys to find the current active UINavigationController.
    /// - Returns: An optional UINavigationController
    public static func getCurrentNavigationController() -> UINavigationController? {
        
        if let rootViewController = CUStandard.getMainUIWindow()?.rootViewController {
            
            // Search for the UINavigationController
            for vc in rootViewController.children {
                
                // Did we find a UITabBarController? Search in the current
                // selected tab for an UINavigationController
                if let tabBarController = vc as? UITabBarController {
                    let currentTabIndex = tabBarController.selectedIndex
                    let currentTabViewController = vc.children[currentTabIndex]
                    for vc2 in currentTabViewController.children {
                        if(vc2 is UINavigationController) {
                            if let navigationController = vc2 as? UINavigationController {
                                return navigationController
                            }
                        }
                    }
                }else { // Without UITabBarController
                    // Check if the first viewController is a UINavigationController
                    if let navigationController = vc as? UINavigationController {
                        return navigationController
                    }else { // Continue search in subviews
                        for vc2 in vc.children {
                            if let navigationController = vc2 as? UINavigationController {
                                return navigationController
                            }
                        }
                    }
                }
            }
        }
        
        print("CUNavigation.getCurrentNavigationController() -> CURRENT UINAVIGATIONCONTROLLER NOT FOUND!")
        return nil
    }
    
    /// Try's to push to a SwiftUI View inside the current UINavigationController
    public static func pushToSwiftUiView<Content: View>(_ view: Content, animated: Bool = true){
        if let navigationController = self.getCurrentNavigationController() {
            let viewController = UIHostingController(rootView: view)
            viewController.navigationItem.largeTitleDisplayMode = .never
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    /// Pushes to a native UISheetPresentationController
    public static func pushBottomSheet<Content: View>(_ view: Content, size: CUNavigation.BottomSheetSize = .halfAllowFull){
        var detents: [UISheetPresentationController.Detent]
        
        switch size {
        case .halfDontAllowFull:
            detents = [.medium()]
        case .fullDontAllowHalf:
            detents = [.large()]
        case .fullAllowHalf:
            detents = [.large(), .medium()]
        case .halfAllowFull:
            detents = [.medium(), .large()]
        }
        
        if let rootViewController = CUStandard.getMainUIWindow()?.rootViewController {
            let sheetHostingController = SheetHostingController(rootView: view, detents: detents)
            rootViewController.present(sheetHostingController, animated: true)
        }
    }
}

final class SheetHostingController<T: View>: UIHostingController<T>, UISheetPresentationControllerDelegate {
    
    private let detents: [UISheetPresentationController.Detent]
    private let prefersEdgeAttachedInCompactHeight: Bool
    private let prefersScrollingExpandsWhenScrolledToEdge: Bool
    
    init(
        rootView: T,
        title: String? = nil,
        largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode  = .never,
        detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
        prefersEdgeAttachedInCompactHeight: Bool = true,
        prefersScrollingExpandsWhenScrolledToEdge: Bool = true
    ) {
        self.detents = detents
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        super.init(rootView: rootView)
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetPresentationController = presentationController as? UISheetPresentationController {
            sheetPresentationController.delegate = self
            sheetPresentationController.detents = detents
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        }
    }
    
    func set(to detentIdentifier: UISheetPresentationController.Detent.Identifier?) {
        guard let sheetPresentationController = presentationController as? UISheetPresentationController else { return }
        sheetPresentationController.animateChanges {
            sheetPresentationController.selectedDetentIdentifier = detentIdentifier
        }
    }
}
