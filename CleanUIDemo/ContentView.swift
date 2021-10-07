//
//  ContentView.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 04.10.21.
//

import SwiftUI
import CleanUI

struct ContentView: View {
    @State private var text: String = ""
    var body: some View {
        NavigationView {
            List {
                Section(header: CLFeedTitle("TextEditors")) {
                    NavigationLink(destination: {
                        VStack(spacing: 20) {
                            Text("CLSingleLineTextEditor() is a single line text editor which expands on line break. Besides that, CLSingleLineTextEditor() is able to show hashtags, mentions and links in realtime.")
                            CLSingleLineTextEditor($text)
                        }
                        .padding()
                        .navigationBar("CLSingleLineTextEditor()")
                    }) {
                        Text("CLSingleLineTextEditor()")
                    }
                    
                    NavigationLink(destination: {
                        CLBetterTextEditor($text)
                            .padding()
                            .navigationBar("CLBetterTextEditor()")
                    }) {
                        Text("CLBetterTextEditor()")
                    }
                }
            }
            .navigationBar("CleanUI Demo", bigTitle: true)
        }
    }
}
