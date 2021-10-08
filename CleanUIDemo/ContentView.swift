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
                            ZStack {
                                Color.accent
                                Text("Color.accent")
                            }
                            ZStack {
                                Color.accent2
                                Text("Color.accent2")
                            }
                            ZStack {
                                Color.accent3
                                Text("Color.accent3")
                            }
                            ZStack {
                                Color.accent4
                                Text("Color.accent4")
                            }
                            ZStack {
                                Color.defaultText
                                Text("Color.defaultText")
                            }
                            ZStack {
                                Color.grayText
                                Text("Color.grayText")
                            }
                            
                            Group {
                                ZStack {
                                    Color.link
                                    Text("Color.link")
                                }
                                ZStack {
                                    Color.defaultRed
                                    Text("Color.defaultRed")
                                }
                                ZStack {
                                    Color.background
                                    Text("Color.background")
                                }
                                ZStack {
                                    Color.primaryColor
                                    Text("Color.primaryColor")
                                }
                                ZStack {
                                    Color.accentStaticDark
                                    Text("Color.accentStaticDark")
                                }
                                ZStack {
                                    Color.defaultBorder
                                    Text("Color.defaultBorder")
                                }
                            }
                        }
                        .foregroundColor(.secondary)
                        .navigationBar("Colors", bigTitle: true)
                    }) {
                        Text("Colors")
                    }
                }
                
                Section(header: CLFeedTitle("TextEditors")) {
                    NavigationLink(destination: {
                        ViewPresentationWrapperPage("CLSingleLineTextEditor()", description: "CLSingleLineTextEditor() is a single line text editor which expands on line break. Besides that, CLSingleLineTextEditor() is able to show hashtags, mentions and links in realtime."){
                            CLSingleLineTextEditor($text, placeholder: "Placeholder")
                        }
                    }) {
                        Text("CLSingleLineTextEditor()")
                    }
                    
                    NavigationLink(destination: {
                        ViewPresentationWrapperPage("CLTextEditor()", description: "CLTextEditor() is a multi line text editor which expands on line break. Besides that, CLSingleLineTextEditor() is able to show hashtags, mentions and links in realtime."){
                            CLTextEditor($text, placeholder: "Placeholder")
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
