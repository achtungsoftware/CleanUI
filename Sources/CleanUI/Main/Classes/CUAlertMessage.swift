//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// ``CUAlertMessage`` is able to show a toast like message at the bottom of the
/// screen. ``CUAlertMessage`` uses ``CLInfoCard``'s.
public class CUAlertMessage {
    
    /// Adds a new alert message to the ``CUGlobal/alertMessages`` array, and shows it
    /// - Parameters:
    ///   - title: The title label to show
    ///   - title: The subtitle label to show
    ///   - type: The ``CLInfoCard/InfoCardType`` alert type, default is `.info`
    public static func show(_ title: String, subTitle: String = "", type: CLInfoCard.InfoCardType = .info) {
        CUGlobal.alertMessages.add(title, subTitle: subTitle, type: type)
    }
    
    /// Clears a single message
    /// - Parameter id: The id for the message
    public static func clearSingle(_ id: UUID) {
        CUGlobal.alertMessages.clearSingle(id)
    }
}

/// This class handles all alert messages
public class CUAlertMessages {
    
    var messages: [CUAlertModel] = []
    
    func clearSingle(_ id: UUID) {
        for message in messages {
            if message.id == id {
                message.view.removeFromSuperview()
            }
        }
    }
    
    func add(_ title: String, subTitle: String = "", type: CLInfoCard.InfoCardType = .info) {
        let id: UUID = UUID()
        
        if let controller = CUStd.getMainUIWindow()?.rootViewController {
            let infoCardController = UIHostingController(rootView: CLAlertMessageView(id: id, title: title, subTitle: subTitle, type: type))
            controller.view.addSubview(infoCardController.view)
            infoCardController.view.translatesAutoresizingMaskIntoConstraints = false
            infoCardController.view.backgroundColor = .clear
            infoCardController.view.isUserInteractionEnabled = false
            
            
            
            let c1 = NSLayoutConstraint(item: infoCardController.view!, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 10)
            let c2 = NSLayoutConstraint(item: infoCardController.view!, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -10)
            let c3 = NSLayoutConstraint(item: infoCardController.view!, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: 0)
            
            controller.view.addConstraints([c1, c2, c3])
            
            
            UIView.animate(withDuration:0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [UIView.AnimationOptions.curveEaseIn], animations: { () -> Void in
                
                infoCardController.view.frame.origin.y = -200
            },  completion: {
                (value: Bool) in
            })
            
            messages.append(CUAlertModel(id: id, view: infoCardController.view))
            CUVibrate.light.vibrate()
        }
    }
}


struct CLAlertMessageView: View {
    
    let id: UUID
    var title: String
    var subTitle: String
    var type: CLInfoCard.InfoCardType
    
    @State private var show: Bool = true
    
    var body: some View {
        if show {
            VStack {
                CLInfoCard(title, subTitle: subTitle, type: type)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.background)
                    )
                
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: 48)
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .onLoad {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    close()
                }
            }
        }else {
            EmptyView()
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
