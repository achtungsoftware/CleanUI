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

/// ``CUSheet`` allows to show and hide Sheets
public class CUSheet {
    
    public static let shared: CUSheet = CUSheet()
    
    /// Shows an ``CLSheet``
    /// - Parameters:
    ///   - content: The content `View` for the Sheet
    public static func show<Content: View>(_ content: Content){
        CUSheet.shared.add(content)
    }
    
    /// Clears / dismisses all ``CUSheet``'s
    public static func clearAll() {
        CUSheet.shared.clearAll()
    }
    
    public var alerts: [CUAlertModel] = []
    
    public func clearAll() {
        if !alerts.isEmpty {
            for alert in alerts {
                alert.view.removeFromSuperview()
            }
        }
        alerts = []
    }
    
    public func add<Content: View>(_ content: Content) {
        
        clearAll()
        
        if let controller = CUStd.getMainUIWindow()?.rootViewController {
            let sheetView = UIHostingController(rootView: CLSheet(content: content))
            controller.view.addSubview(sheetView.view)
            sheetView.view.isUserInteractionEnabled = true
            sheetView.view.backgroundColor = .clear
            sheetView.view.center = controller.view.center
            sheetView.view.alpha = 0.0
            
            sheetView.view.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 0).isActive = true
            sheetView.view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: 0).isActive = true
            sheetView.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0).isActive = true
            sheetView.view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0).isActive = true
            sheetView.view.translatesAutoresizingMaskIntoConstraints = false
            
            UIView.animate(withDuration: 0.2) {
                sheetView.view.alpha = 1.0
            }
            
            // Close Keyboard
            UIApplication.shared.endEditing()
            
            alerts.append(CUAlertModel(view: sheetView.view))
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

public struct CLSheetMenuItem: Identifiable {
    
    public init(title: String, show: Bool, action: @escaping () -> Void, icon: CLIcon? = nil, foregroundColor: Color? = nil) {
        self.title = title
        self.show = show
        self.action = action
        self.icon = icon
        self.foregroundColor = foregroundColor
    }
    
    public var id = UUID()
    public var title: String
    public var show: Bool
    public var action: () -> Void
    public var icon: CLIcon?
    public var foregroundColor: Color?
}

struct CLSheet_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Button(action: {
                CUSheet.show(VStack {
                    Text("Hallo, Welt!")
                    Text("Hallo, Welt!")
                    Text("Hallo, Welt!")
                    Text("Hallo, Welt!")
                })
            }){
                Text("Show")
            }
        }
    }
}
