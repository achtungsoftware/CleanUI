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
                CLRichText(text, attributes: [.links(onTapAction: { value in
                    print(value)
                })])
                
                
                Section(header: CLFeedTitle("TextEditors")) {
                    NavigationLink(destination: {
                        VStack(spacing: 20) {
                            Text("CLSingleLineTextEditor() is a single line text editor which expands on line break. Besides that, CLSingleLineTextEditor() is able to show hashtags, mentions and links in realtime.")
                            CLSingleLineTextEditor($text)
                        }
                        .padding()
                    }) {
                        Text("CLSingleLineTextEditor()")
                    }
                    
                    NavigationLink(destination: {
                        CLTextEditor($text)
                            .padding()
                            .navigationBar("CLTextEditor()")
                    }) {
                        Text("CLTextEditor()")
                    }
                }
            }
            .navigationBar("CleanUI Demo", bigTitle: true)
        }
    }
}
