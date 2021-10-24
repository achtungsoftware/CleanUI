//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

public extension View {
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies the view modifier ``OnLoad`` to a view
    /// - Parameter action: The action gets called only once on appear. Gets not called if already appeared
    /// - Returns: The view with the ``OnLoad`` modifier
    func onLoad(perform action: @escaping (() -> Void)) -> some View {
        modifier(OnLoad(perform: action))
    }
    
    /// Applies the view modifier ``HideNavigationBar`` to a view
    /// - Returns: The view with the ``HideNavigationBar`` modifier
    func hideNavigationBar() -> some View {
        modifier(HideNavigationBar())
    }
    
    /// Applies the view modifier ``OnRotate`` to a view
    /// - Parameter action: The on rotate action
    /// - Returns: The view with the ``OnRotate`` modifier
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        modifier(OnRotate(action: action))
    }
    
    /// Applies the view modifier ``PinchToZoom`` to a view
    /// - Returns: The view with the ``PinchToZoom`` modifier
    func pinchToZoom() -> some View {
        modifier(PinchToZoom())
    }
    
    /// Applies the view modifier ``NavigationBar`` to a view
    /// - Returns: The view with the ``NavigationBar`` modifier
    func navigationBar(_ title: String = "", subTitle: String = "", bigTitle: Bool = false, customTitle: AnyView? = nil, buttons: AnyView? = nil, searchBar: NavigationBarSearchField? = nil) -> some View {
        modifier(NavigationBar(title: title, subTitle: subTitle, bigTitle: bigTitle, customTitle: customTitle, buttons: buttons, searchBar: searchBar))
    }
    
    /// Applies the frameworks default shadow to a view
    /// - Returns: The view with the default shadow
    func defaultShadow() -> some View {
        return self.shadow(color: Color.black.opacity(0.4), radius: 3)
    }
    
    /// Clipshapes the view wit an ``RoundedCorner`` `Shape`
    /// - Parameters:
    ///   - radius: The radius
    ///   - corners: The corners which the radius should apply to
    /// - Returns: The clipped `View`
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
