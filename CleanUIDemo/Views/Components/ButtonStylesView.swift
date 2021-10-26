//
//  ButtonStylesView.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 26.10.21.
//

import SwiftUI
import CleanUI

struct ButtonStylesView: View {
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {}) {
                    Text("SecondaryButtonStyle().normal")
                }
                .buttonStyle(SecondaryButtonStyle())
                
                Button(action: {}) {
                    Text("SecondaryButtonStyle().small")
                }
                .buttonStyle(SecondaryButtonStyle(size: .small))
                
                Button(action: {}) {
                    Text("PrimaryButtonStyle() .primary")
                }
                .buttonStyle(PrimaryButtonStyle())
                
                Button(action: {}) {
                    Text("PrimaryButtonStyle() .secondary")
                }
                .buttonStyle(PrimaryButtonStyle(buttonTheme: .secondary))
                
                Button(action: {}) {
                    Text("PrimaryButtonStyle() .imageOverlay")
                }
                .buttonStyle(PrimaryButtonStyle(buttonTheme: .imageOverlay))
                
                Button(action: {}) {
                    Text("PrimaryButtonStyle() .materialDark")
                }
                .buttonStyle(PrimaryButtonStyle(buttonTheme: .materialDark))
                
                Button(action: {}) {
                    Text("PrimaryButtonStyle() .materialLight")
                }
                .buttonStyle(PrimaryButtonStyle(buttonTheme: .materialLight))
                
                Button(action: {}) {
                    Text("PrimaryButtonStyle() .staticDark")
                }
                .buttonStyle(PrimaryButtonStyle(buttonTheme: .staticDark))
                
                Button(action: {}) {
                    Text("PrimaryButtonStyle() .staticLight")
                }
                .buttonStyle(PrimaryButtonStyle(buttonTheme: .staticLight))
            }
            .padding()
        }
        .navigationBar("ButtonStyles")
    }
}
