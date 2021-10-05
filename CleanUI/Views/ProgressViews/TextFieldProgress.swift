//
//  TextFieldProgress.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// Returns a ``TextFieldProgress`` view for indication how much the user is allowed to type inside a TextField or TextEditor
public struct TextFieldProgress: View {
    
    @Binding var text: String
    var characterLimit: Int
    
    /// - Parameters:
    ///   - text: The binding text (String)
    ///   - characterLimit: The character limit
    public init(_ text: Binding<String>, characterLimit: Int) {
        self._text = text
        self.characterLimit = characterLimit
    }
    
    @State private var progress: Float = 0
    @State private var remainingCharacters: Int = 0
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2.0)
                .foregroundColor(Color.gray)
                .opacity(0.6)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 2.0))
                .foregroundColor(Color.primaryColor)
                .rotationEffect(Angle(degrees: 270.0))
            
            if(remainingCharacters < 0){
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(Color.defaultRed)
                    Circle()
                        .fill(Color.defaultRed)
                }
            }
        }
        .frame(width: 22, height: 22)
        .onChange(of: text) { value in
            withAnimation {
                progress = Float(value.count) / Float(characterLimit)
                remainingCharacters = characterLimit - value.count
            }
        }
        .onLoad {
            remainingCharacters = characterLimit - text.count
        }
    }
}
