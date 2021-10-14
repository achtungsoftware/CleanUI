//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI

/// ``CUSheet`` allows to show and hide Sheets
public class CUSheet {
    
    /// Adds a new sheet to the ``CUGlobal/sheets`` array, and shows it
    /// - Parameters:
    ///   - content: The content `View` for the Sheet
    public static func show<Content: View>(_ content: Content){
        CUGlobal.sheets.add(content)
    }
    
    /// Clears / dismisses all ``CUSheet``'s
    public static func clearAll(){
        CUGlobal.sheets.clearAll()
    }
}

/// This class handles all Sheets
public class CUSheets {
    
    var alerts: [CUAlertModel] = []
    
    func clearAll() {
        if(!alerts.isEmpty){
            for alert in alerts {
                alert.view.removeFromSuperview()
            }
        }
        alerts = []
    }
    
    func add<Content: View>(_ content: Content) {
        
        clearAll()
        
        if let controller = CUStandard.getMainUIWindow()?.rootViewController {
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
    
    public init(title: String, show: Bool, action: @escaping () -> Void, icon: CLIcon? = nil, foregroundColor: Color? = nil){
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
