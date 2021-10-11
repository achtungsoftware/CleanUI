//
//  CUAlert.swift
//  CleanUI
//
//  Created by Julian Gerhards on 10.10.21.
//

import SwiftUI

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
}

/// This class handles all alerts
public class CUAlerts {
    
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
            let alertView = UIHostingController(rootView: CLALertView(content: content))
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

/// ``CLAlertConfirmView`` is a action confirmation view for ``CUAlert``
public struct CLAlertConfirmView: View {
    
    var title: String
    var subTitle: String
    var confirmAction: () -> Void
    
    /// - Parameters:
    ///   - title: The title `String`
    ///   - subTitle: The optional sub title `String`
    ///   - confirmAction: The action for the continue button
    public init(_ title: String, subTitle: String = "", confirmAction: @escaping () -> Void) {
        self.title = title
        self.subTitle = subTitle
        self.confirmAction = confirmAction
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text(title)
                    .font(.title3.bold())
                    .padding(.bottom, 8)
                
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .font(.subheadline)
                }
            }
            
            Divider()
            
            HStack {
                Button(action: {
                    CUAlert.clearAll()
                }, label: {
                    Text(CULanguage.getStringCleanUI("cancel"))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 5)
                })
                
                Divider()
                    .frame(height: 25)
                
                Button(action: {
                    confirmAction()
                    CUAlert.clearAll()
                }, label: {
                    Text(CULanguage.getStringCleanUI("continue"))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 5)
                })
            }
            .font(.subheadline)
            .foregroundColor(Color.defaultText)
        }
    }
}

struct CLALertView<Content: View>: View {
    
    var content: Content
    
    @State private var show: Bool = false
    
    var body: some View {
        ZStack {
            if(show){
                Color.black
                    .opacity(0.25)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .onTapGesture {
                        close()
                    }
                
                VStack(spacing: 0) {
                    content
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.alert)
                )
                .padding()
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.3)) {
                show = true
            }
        }
    }
    
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.25)) {
            show = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            CUAlert.clearAll()
        }
    }
}
