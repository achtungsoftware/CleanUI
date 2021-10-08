//
//  CLTextEditorDemo.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 08.10.21.
//

import SwiftUI
import CleanUI

struct CLTextEditorDemo: View {
    
    @State private var text: String = ""
    
    var body: some View {
        CLTextEditor($text, placeholder: "Placeholder")
    }
}
