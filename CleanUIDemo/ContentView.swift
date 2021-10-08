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
        CLNavigationView {
            List {
                Section(header: CLFeedTitle("Standard")) {
                    NavigationLink(destination: {
                        VStack {
                            Color.accent
                            Color.accent2
                            Color.accent3
                            Color.accent4
                            Color.defaultText
                            Color.grayText
                            Group {
                                Color.link
                                Color.defaultRed
                                Color.background
                                Color.primaryColor
                                Color.accentStaticDark
                                Color.defaultBorder
                            }
                        }
                    }) {
                        Text("Colors")
                    }
                }

                Section(header: CLFeedTitle("TextEditors")) {
                    NavigationLink(destination: {
                        ViewPresentationWrapperPage("CLSingleLineTextEditor()", description: "CLSingleLineTextEditor() is a single line text editor which expands on line break. Besides that, CLSingleLineTextEditor() is able to show hashtags, mentions and links in realtime."){
                            CLSingleLineTextEditorDemo()
                        }
                    }) {
                        Text("CLSingleLineTextEditor()")
                    }

                    NavigationLink(destination: {
                        ViewPresentationWrapperPage("CLTextEditor()", description: "CLTextEditor() is a multi line text editor which expands on line break. Besides that, CLSingleLineTextEditor() is able to show hashtags, mentions and links in realtime."){
                            CLTextEditorDemo()
                        }
                    }) {
                        Text("CLTextEditor()")
                    }
                }
            }
            .navigationBar("CleanUI Demo", bigTitle: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
