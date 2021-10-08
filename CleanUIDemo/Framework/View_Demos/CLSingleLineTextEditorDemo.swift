//
//  CLSingleLineTextEditor.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 08.10.21.
//

import SwiftUI
import CleanUI

struct CLSingleLineTextEditorDemo: View {
    
    @State private var text: String = ""
    
    var body: some View {
        CLSingleLineTextEditor($text, placeholder: "Placeholder")
    }
}
