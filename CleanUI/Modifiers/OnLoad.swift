//
//  OnLoad.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// The ``OnLoad`` ViewModifier allows to add a .onLoad { action() } to a view,
/// The action() never gets called twice
public struct OnLoad: ViewModifier {
    
    @State private var didLoad = false
    private let action: (() -> Void)
    
    /// - Parameter action: The action gets called only once on appear. Gets not called if already appeared
    public init(perform action: @escaping (() -> Void)) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if !didLoad {
                    action()
                    didLoad = true
                }
            }
    }
}
