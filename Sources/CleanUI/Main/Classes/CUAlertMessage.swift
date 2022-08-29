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

/// ``CUAlertMessage`` is able to show a toast like message at the bottom of the
/// screen. ``CUAlertMessage`` uses ``CLInfoCard``'s.
public class CUAlertMessage {
    
    public static let shared: CUAlertMessage = CUAlertMessage()
    
    /// Shows a ``CUAlertMessage``
    /// - Parameters:
    ///   - title: The title label to show
    ///   - title: The subtitle label to show
    ///   - type: The ``CLInfoCard/InfoCardType`` alert type, default is `.info`
    public static func show(_ title: String, subTitle: String = "", type: CLInfoCard.InfoCardType = .info) {
        CUAlertMessage.shared.add(title, subTitle: subTitle, type: type)
    }
    
    /// Clears a single message
    /// - Parameter id: The id for the message
    public static func clearSingle(_ id: UUID) {
        CUAlertMessage.shared.clearSingle(id)
    }
    
    public var messages: [CUAlertModel] = []
    
    public func clearSingle(_ id: UUID) {
        for message in messages {
            if message.id == id {
                message.view.removeFromSuperview()
            }
        }
    }
    
    public func add(_ title: String, subTitle: String = "", type: CLInfoCard.InfoCardType = .info) {
        
        let id: UUID = UUID()
        
        if let controller = CUStd.getMainUIWindow()?.rootViewController {
            let infoCardController = UIHostingController(rootView: CLAlertMessageView(id: id, title: title, subTitle: subTitle, type: type))
            controller.view.addSubview(infoCardController.view)
            infoCardController.view.backgroundColor = .clear
            infoCardController.view.isUserInteractionEnabled = false
            
            
            let c1 = NSLayoutConstraint(item: infoCardController.view!, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 8)
            let c2 = NSLayoutConstraint(item: infoCardController.view!, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -8)
            
            var c3: NSLayoutConstraint
            
            if let tabbar = findUITabBarController() {
                c3 = NSLayoutConstraint(item: infoCardController.view!, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -(tabbar.tabBar.frame.height + 8))
            }else {
                c3 = NSLayoutConstraint(item: infoCardController.view!, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -8)
            }
            
            controller.view.addConstraints([c1, c2, c3])
            infoCardController.view.translatesAutoresizingMaskIntoConstraints = false
            
            messages.append(CUAlertModel(id: id, view: infoCardController.view))
            
            infoCardController.view.layoutIfNeeded()
            
            UIView.animate(withDuration:0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [UIView.AnimationOptions.curveEaseIn], animations: { () -> Void in
                
                infoCardController.view.layoutIfNeeded()
                infoCardController.view.frame.origin.y = -200
            },  completion: {
                (value: Bool) in
            })
            
            CUVibrate.light.vibrate()
        }
    }
    
    func findUITabBarController() -> UITabBarController? {
        if let rootViewController = CUStd.getMainUIWindow()?.rootViewController {
            for vc in rootViewController.children {
                if let tabBarController = vc as? UITabBarController {
                    return tabBarController
                }
            }
        }
        
        return nil
    }
}


struct CLAlertMessageView: View {
    
    let id: UUID
    var title: String
    var subTitle: String
    var type: CLInfoCard.InfoCardType
    
    @State private var show: Bool = true
    @State private var size: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear
                .readSize { _size in
                    size = _size
                }
            
            if show {
                
                CLInfoCard(title, subTitle: subTitle, type: type)
                    .frame(width: size.width.maxValue(500))
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .onLoad {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                            close()
                        }
                    }
                
            }
        }
    }
    
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            show = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            CUAlertMessage.clearSingle(id)
        }
    }
}

struct CLAlertMessageView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Button(action: {
                CUAlertMessage.show("Test")
            }){
                Text("Show")
            }
        }
    }
}
