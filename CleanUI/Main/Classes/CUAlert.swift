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
    ///   - title: The title `String`
    ///   - body: The body `String`
    ///   - closeable: Should the user be able to close the alert?, default is `true`
    ///   - hideAfterAction: Should the alert dismiss itself after the action is finished?, default is `true`
    ///   - action: The action for the continue button, default is `nil`
    ///   - content: The content `View`, default is `nil`
    public static func show(title: String, body: String, closeable: Bool = true, hideAfterAction: Bool = true, action: (() -> ())? = nil, content: AnyView? = nil){
        CUGlobal.alerts.add(title: title, body: body, closeable: closeable, hideAfterAction: hideAfterAction, action: action, content: content)
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
    
    func add(title: String, body: String, closeable: Bool = true, hideAfterAction: Bool = true, action: (() -> ())? = nil, content: AnyView?) {
        
        clearAll()
        
        if let controller = CUStandard.getMainUIWindow()?.rootViewController {
            let alertTemp = UIHostingController(rootView: CLALertView(title: title, bodyT: body, closeable: closeable, hideAfterAction: hideAfterAction, action: action, content: content))
            controller.view.addSubview(alertTemp.view)
            alertTemp.view.isUserInteractionEnabled = true
            alertTemp.view.backgroundColor = .clear
            alertTemp.view.center = controller.view.center
            alertTemp.view.alpha = 0.0
            
            alertTemp.view.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 0).isActive = true
            alertTemp.view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: 0).isActive = true
            alertTemp.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0).isActive = true
            alertTemp.view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0).isActive = true
            alertTemp.view.translatesAutoresizingMaskIntoConstraints = false
            
            UIView.animate(withDuration: 0.2) {
                alertTemp.view.alpha = 1.0
            }
            
            // Close Keyboard
            UIApplication.shared.endEditing()
            
            alerts.append(CUAlertModel(view: alertTemp.view))
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

struct CLALertView: View {
    
    var title: String
    var bodyT: String
    var closeable: Bool
    var hideAfterAction: Bool
    var action: (() -> ())?
    var content: AnyView?
    
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
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color.defaultText)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    if(content != nil){
                        content
                    }else {
                        Text(bodyT)
                            .font(.subheadline)
                            .foregroundColor(Color.defaultText)
                            .multilineTextAlignment(.center)
                    }
                    
                    if(action != nil){
                        Divider()
                            .padding(16)
                        HStack {
                            Button(action: {
                                close()
                            }, label: {
                                Text(CULanguage.getStringCleanUI("cancel"))
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 5)
                            })
                            Divider()
                                .frame(height: 25)
                            Button(action: {
                                action!()
                                if(hideAfterAction){
                                    close()
                                }
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
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.regularMaterial)
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
