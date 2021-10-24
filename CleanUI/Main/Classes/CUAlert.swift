//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// ``CUAlert`` allows to show and hide Alerts
public class CUAlert {
    
    /// Adds a new alert to the ``CUGlobal/alerts`` array, and shows it
    /// - Parameters:
    ///   - content: The content `View` for the Alert
    public static func show<Content: View>(_ content: Content){
        CUGlobal.alerts.add(content)
    }
    
    /// Clears / dismisses all ``CUAlert``'s
    public static func clearAll(){
        CUGlobal.alerts.clearAll()
    }
    
    var alerts: [CUAlertModel] = []
    
    private func clearAll() {
        if(!alerts.isEmpty){
            for alert in alerts {
                alert.view.removeFromSuperview()
            }
        }
        
        alerts = []
    }
    
    private func add<Content: View>(_ content: Content) {
        
        clearAll()
        
        if let controller = CUStd.getMainUIWindow()?.rootViewController {
            let alertView = UIHostingController(rootView: CLALert(content: content))
            controller.view.addSubview(alertView.view)
            alertView.view.isUserInteractionEnabled = true
            alertView.view.backgroundColor = .clear
            alertView.view.center = controller.view.center
            alertView.view.alpha = 0.0
            
            alertView.view.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 0).isActive = true
            alertView.view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: 0).isActive = true
            alertView.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0).isActive = true
            alertView.view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0).isActive = true
            alertView.view.translatesAutoresizingMaskIntoConstraints = false
            
            UIView.animate(withDuration: 0.2) {
                alertView.view.alpha = 1.0
            }
            
            // Close Keyboard
            UIApplication.shared.endEditing()
            
            alerts.append(CUAlertModel(view: alertView.view))
        }
    }
    
    func dismiss(view: UIView){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            view.alpha = 0.0
        }, completion: {_ in
            view.removeFromSuperview()
        })
    }
}
