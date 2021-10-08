//
//  CLInfoCard.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI


/// ``InfoCardManagerModel`` manages the ``CLInfoCardManager``
public class InfoCardManagerModel: ObservableObject {
    
    @Published var isVisible: Bool = false
    @Published var title: String = ""
    @Published var subTitle: String = ""
    @Published var type: CLInfoCard.InfoCardType = .info
    
    public init() {}
    
    /// Shows a new ``CLInfoCard` or replaces the old one with animation
    /// - Parameters:
    ///   - title: The main text to display inside the card
    ///   - subTitle: The secondary text to display inside the card
    ///   - type: The ``CLInfoCard/InfoCardType``, default is `.info`
    public func show(_ title: String, subTitle: String = "", type: CLInfoCard.InfoCardType = .info) {
        withAnimation {
            self.title = title
            self.subTitle = subTitle
            self.type = type
            self.isVisible = true
        }
    }
    
    /// Hides all InfoCards with animation
    public func hide(){
        withAnimation {
            self.isVisible = false
        }
    }
}

/// Returns a view which is able to decide if and which ``CLInfoCard`` should be displayed based on a ``InfoCardManagerModel``
public struct CLInfoCardManager: View {
    
    @ObservedObject var manager: InfoCardManagerModel
    
    /// - Parameter manager: Needs a ``InfoCardManagerModel`` for managing the CLInfoCard
    public init(_ manager: InfoCardManagerModel) {
        self.manager = manager
    }
    
    public var body: some View {
        Group {
            if manager.isVisible {
                CLInfoCard(manager.title, subTitle: manager.subTitle, type: manager.type)
            }else {
                EmptyView()
            }
        }
    }
}

/// Returns a view, in style of a card with text for information. If there is the possibility that multiple ``CLInfoCard``'s
/// gets shown, consider using a ``CLInfoCardManager`` instead.
public struct CLInfoCard: View {
    
    public enum InfoCardType {
        case error, success, info
    }
    
    var title: String
    var subTitle: String
    var type: InfoCardType
    
    /// - Parameters:
    ///   - title: The main Text to display inside the card
    ///   - subTitle: The secondary Text to display inside the card
    ///   - type: The ``InfoCardType``, default is .info
    public init(_ title: String, subTitle: String = "", type: InfoCardType = .info) {
        self.title = title
        self.subTitle = subTitle
        self.type = type
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Image(systemName: type == .error ? "xmark.octagon" : type == .info ? "info.circle" : "checkmark.seal")
                    .imageScale(.medium)
                    .foregroundColor(type == .error ? Color.defaultRed : type == .info ? .gray : Color.green)
                    .opacity(0.8)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.subheadline)
                    
                    if !subTitle.isEmpty {
                        Text(title)
                            .font(.caption)
                    }
                }
            }
        }
        .foregroundColor(Color.defaultText)
        .padding(10)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(RoundedRectangle(cornerRadius: 10).fill(type == .error ? Color.defaultRed : type == .info ? Color.accent : Color.green).opacity(type == .info ? 1 : 0.3))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(type == .error ? Color.defaultRed : type == .info ? Color.clear : Color.green, lineWidth: 0.5)
                .opacity(type == .info ? 1 : 0.6)
        )
    }
}
