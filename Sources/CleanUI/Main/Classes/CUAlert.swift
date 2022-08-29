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

/// ``CUAlert`` allows to show and hide Alerts
public class CUAlert {
    
    public static let shared: CUAlert = CUAlert()
    
    /// Shows a ``CLAlert``
    /// - Parameters:
    ///   - content: The content `View` for the Alert
    public static func show<Content: View>(_ content: Content){
        CUAlert.shared.add(content)
    }
    
    /// Clears / dismisses all ``CUAlert``'s
    public static func clearAll(){
        CUAlert.shared.clearAll()
    }
    
    public var alerts: [CUAlertModel] = []
    
    private func clearAll() {
        if !alerts.isEmpty {
            for alert in alerts {
                alert.view.removeFromSuperview()
            }
        }
        
        alerts = []
    }
    
    private func add<Content: View>(_ content: Content) {
        
        clearAll()
        
        if let controller = CUStd.getMainUIWindow()?.rootViewController {
            let alertView = UIHostingController(rootView: CLAlert(content: content))
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

struct CLAlert_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Button(action: {
                CUAlert.show(Text("Hallo, Welt!"))
            }){
                Text("Show simple")
            }
            
            Button(action: {
                CUAlert.show(CLAlertConfirmView("Title", subTitle: "Subtitle", confirmAction: {}))
            }){
                Text("Show CLAlertConfirmView")
            }
        }
    }
}
