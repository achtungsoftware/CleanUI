//
//  HideNavigationBar.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// The HideNavigationBar modifier hides the default UINavigationBar
public struct HideNavigationBar: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("")
    }
}
