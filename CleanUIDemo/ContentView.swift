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
                
                Section(header: FeedTitle("TextEditors")) {
                    NavigationLink(destination: {
                        VStack(spacing: 20) {
                            Text("SingleLineTextEditor() is a single line text editor which expands on line break. Besides that, SingleLineTextEditor() is able to show hashtags, mentions and links in realtime.")
                            SingleLineTextEditor($text)
                        }
                        .padding()
                        .navigationBar("SingleLineTextEditor()")
                    }) {
                        Text("SingleLineTextEditor()")
                    }
                    
                    NavigationLink(destination: {
                        BetterTextEditor($text)
                            .padding()
                            .navigationBar("BetterTextEditor()")
                    }) {
                        Text("BetterTextEditor()")
                    }
                }
            }
            .navigationBar("CleanUI Demo", bigTitle: true)
        }
    }
}
