//
//  CUSheet.swift
//  CleanUI
//
//  Created by Julian Gerhards on 10.10.21.
//

import SwiftUI

/// ``CUSheet`` allows to show and hide Sheets
public class CUSheet {
    
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

/// This class handles all ``CUSheets``
public class CUSheets {
    
    var alerts: [AlertModel] = []
    
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
            let alertTemp = UIHostingController(rootView: CUSheetView(content: content))
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
            
            alerts.append(AlertModel(view: alertTemp.view))
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

public struct CUSheetMenuItem: Identifiable {
    
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

/// Returns a title view for a ``CUSheet``
public struct CUSheetTitle: View {
    
    var title: String
    
    public init(_ title: String) {
        self.title = title
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.defaultText)
        }
    }
}

/// Returns a styled menu for ``CUSheet``
public struct CUSheetMenu: View {
    
    var menuItems: [CUSheetMenuItem]
    
    /// - Parameter menuItems: The ``CUSheetMenuItem`` array
    public init(_ menuItems: [CUSheetMenuItem]) {
        self.menuItems = menuItems
    }
    
    public var body: some View {
        ForEach(menuItems, id: \.id) { item in
            if(item.show){
                Button(action: {
                    item.action()
                }, label: {
                    HStack(spacing: 16) {
                        if let icon = item.icon {
                            icon
                        }
                        
                        Text(item.title)
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    .contentShape(Rectangle())
                })
                    .buttonStyle(.plain)
                    .foregroundColor(item.foregroundColor != nil ? item.foregroundColor : Color.defaultText)
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
    }
}

struct CUSheetView<Content: View>: View {
    
    var content: Content
    
    @State private var show: Bool = false
    @State private var showBackground: Bool = false
    @State private var offset = CGSize.zero
    @State var height: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if(showBackground){
                    Color.black
                        .opacity(0.25)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                }
                
                VStack(spacing: 0) {
                    Color.black
                        .opacity(0.01)
                        .onTapGesture {
                            close()
                        }
                    
                    if(show){
                        VStack(spacing: 0) {
                            HStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(.secondary)
                                    .frame(width: 40, height: 5, alignment: .center)
                            }
                            .padding(10)
                            content
                            
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width, height: (geometry.safeAreaInsets.bottom + 50) + abs(offset.height) / 4)
                        }
                        .transition(.move(edge: .bottom))
                        .frame(width: UIScreen.main.bounds.width)
                        .background(.regularMaterial)
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .offset(x: 0, y: offset.height > 0 ? offset.height + 50 : 50)
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .ignoresSafeArea(edges: .bottom)
            .highPriorityGesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { g in
                        if (offset.height > 0 && abs(offset.height) > 60) {
                            close()
                        } else {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                offset = .zero
                            }
                        }
                    }
            )
            .onAppear {
                height = geometry.size.height
                withAnimation(Animation.interpolatingSpring(mass: 0.8, stiffness: 28.5, damping: 11.5, initialVelocity: 9.5)){
                    show = true
                    showBackground = true
                }
            }
        }
    }
    
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            offset.height = height
            showBackground = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            CUSheet.clearAll()
        }
    }
}

