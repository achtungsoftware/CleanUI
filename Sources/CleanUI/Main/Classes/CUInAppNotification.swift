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

/// ``CUInAppNotification`` allows to show and hide in app notifications
public class CUInAppNotification {
    
    public static let shared: CUInAppNotification = CUInAppNotification()
    
    /// Shows a new Notification View coming from the top
    /// - Parameters:
    ///   - title: The title `String` for the notification
    ///   - body: The body `String` for the notification
    ///   - tapAction: The tap action, default is `nil`
    ///   - vibration: The `CUVibrate` vibration type, if no vibration needed use `.none`. Default is, `.oldSchool`
    public static func show(title: String, body: String, tapAction: (() -> ())? = nil, vibration: CUVibrate = .oldSchool, trailingView: AnyView? = nil) {
        CUInAppNotification.shared.add(title: title, body: body, tapAction: tapAction, vibration: vibration, trailingView: trailingView)
    }
    
    /// Clears a single notification
    /// - Parameter id: The id for the notification
    public static func clearSingle(_ id: UUID) {
        CUInAppNotification.shared.clearSingle(id)
    }
    
    public var notifications: [CUAlertModel] = []
    
    public func clearSingle(_ id: UUID) {
        for noti in notifications {
            if noti.id == id {
                noti.view.removeFromSuperview()
            }
        }
    }
    
    public func add(title: String, body: String, tapAction: (() -> ())?, vibration: CUVibrate, trailingView: AnyView?) {
        
        let id: UUID = UUID()
        
        if let controller = CUStd.getMainUIWindow()?.rootViewController {
            let notificationView = UIHostingController(rootView: CLInAppNotificationView(id: id, title: title, subTitle: body, trailingView: trailingView, tapAction: tapAction))
            controller.view.addSubview(notificationView.view)
            notificationView.view.isUserInteractionEnabled = true
            notificationView.view.backgroundColor = .clear
            
            let c1 = NSLayoutConstraint(item: notificationView.view!, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 8)
            let c2 = NSLayoutConstraint(item: notificationView.view!, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -8)
            let c3 = NSLayoutConstraint(item: notificationView.view!, attribute: .top, relatedBy: .equal, toItem: controller.view, attribute: .top, multiplier: 1, constant: 8)
            
            controller.view.addConstraints([c1, c2, c3])
            notificationView.view.translatesAutoresizingMaskIntoConstraints = false
            
            notifications.append(CUAlertModel(id: id, view: notificationView.view))
            
            notificationView.view.layoutIfNeeded()
            
            UIView.animate(withDuration:0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [UIView.AnimationOptions.curveEaseInOut], animations: { () -> Void in
                
                notificationView.view.layoutIfNeeded()
                notificationView.view.frame.origin.y = 8
            },  completion: {
                (value: Bool) in
            })
            
            vibration.vibrate()
        }
    }
}

struct CLInAppNotificationView: View {
    
    let id: UUID
    var title: String
    var subTitle: String
    var trailingView: AnyView?
    var tapAction: (() -> ())?
    
    @State private var show: Bool = true
    @State private var offset: CGSize = .zero
    @State private var screenSize: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
                .readSize { value in
                    screenSize = value
                }
            
            if show {
                HStack {
                    
                    if let trailingView = trailingView {
                        trailingView
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(title)
                                .font(.subheadline)
                                .foregroundColor(Color.defaultText)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                        }
                        HStack {
                            Text(subTitle)
                                .lineLimit(1)
                                .font(.subheadline)
                                .foregroundColor(Color.defaultText)
                            Spacer()
                        }
                    }
                }
                .padding(16)
                .frame(width: screenSize.width.maxValue(500))
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.regularMaterial)
                )
                .highPriorityGesture (
                    DragGesture(coordinateSpace: .global)
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { g in
                            if (g.predictedEndTranslation.height < -30) {
                                close()
                            } else {
                                withAnimation(Animation.easeInOut(duration: 0.3)) {
                                    offset = .zero
                                }
                            }
                        }
                )
                .offset(y: offset.height < 0 ? offset.height : 0)
                .transition(.move(edge: .top).combined(with: .opacity))
                .onTapGesture {
                    if let tapAction = tapAction {
                        tapAction()
                    }
                }
                .onLoad {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
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
            CUInAppNotification.clearSingle(id)
        }
    }
}

struct CLInAppNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Button(action: {
                CUInAppNotification.show(title: "Test Title", body: "Test Body")
            }){
                Text("Show")
            }
        }
    }
}
