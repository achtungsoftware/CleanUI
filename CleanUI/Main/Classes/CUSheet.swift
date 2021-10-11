//
//  CUSheet.swift
//  CleanUI
//
//  Created by Julian Gerhards on 10.10.21.
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
            let sheetView = UIHostingController(rootView: CLSheetView(content: content))
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

/// Returns a title view for a ``CUSheet``
public struct CLSheetTitle: View {
    
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

/// ``CLSheetConfirmView`` is a action confirmation view for ``CUSheet``
public struct CLSheetConfirmView: View {
    
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
        VStack(spacing: 12) {
            VStack {
                Text(title)
                    .font(.title2.bold())
                    .padding(.bottom, 8)
                
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .font(.subheadline)
                }
            }
            .padding(.bottom)
            
            Button(action: {
                CUSheet.clearAll()
            }) {
                Text(CULanguage.getStringCleanUI("cancel"))
            }
            .buttonStyle(PrimaryButtonStyle(buttonTheme: .secondary))
            
            Button(action: {
                confirmAction()
                CUSheet.clearAll()
            }) {
                Text(CULanguage.getStringCleanUI("continue"))
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .foregroundColor(Color.defaultText)
    }
}

/// Returns a styled menu for ``CUSheet``
public struct CLSheetMenu: View {
    
    var menuItems: [CLSheetMenuItem]
    
    /// - Parameter menuItems: The ``CLSheetMenuItem`` array
    public init(_ menuItems: [CLSheetMenuItem]) {
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

struct CLSheetView<Content: View>: View {
    
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
                        .opacity(0.001)
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
                        .background(Color.alert)
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
                withAnimation(Animation.interpolatingSpring(mass: 0.2, stiffness: 29.5, damping: 12, initialVelocity: 10)){
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

