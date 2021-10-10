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
                    
                    NavigationLink(destination: {
                        List {
                            Button(action: {
                                CUAlert.show(title: "This is a title", body: "This is the string body", action: {
                                    CUAlertMessage.show(message: "CUAlert action tapped")
                                })
                            }){
                                Text("Test CUAlert")
                            }
                        }
                        .navigationBar("CUAlert()", bigTitle: true)
                    }) {
                        Text("CUAlert()")
                    }
                    
                    NavigationLink(destination: {
                        List {
                            Button(action: {
                                CUSheet.show(
                                    VStack {
                                        Text("This is a CUSheet")
                                            .font(.title)
                                        
                                        Text("And inside is a Button")
                                            .font(.subheadline)
                                        
                                        Button(action: {
                                            CUAlertMessage.show(message: "Button tapped")
                                        }){
                                            Text("Button")
                                        }
                                        .buttonStyle(PrimaryButtonStyle())
                                    }
                                        .padding()
                                )
                            }){
                                Text("Test CUSheet with Text and Button inside")
                            }
                            
                            Button(action: {
                                CUSheet.show(
                                    List {
                                        Text("List item")
                                        Text("List item")
                                        Text("List item")
                                        Text("List item")
                                        Text("List item")
                                    }
                                )
                            }){
                                Text("Test CUSheet with a List inside")
                            }
                            
                            Button(action: {
                                CUSheet.show(
                                    CLScrollView {
                                        VStack {
                                            Text("VStack item")
                                            Text("VStack item")
                                            Text("VStack item")
                                            Text("VStack item")
                                            Text("VStack item")
                                        }
                                    }
                                )
                            }){
                                Text("Test CUSheet with a CLScrollView inside")
                            }
                            
                            Button(action: {
                                CUSheet.show(
                                    CLSingleLineTextEditor($text, placeholder: "Placeholder")
                                        .padding()
                                )
                            }){
                                Text("Test CUSheet with a CLSingleLineTextEditor inside")
                            }
                            
                            Button(action: {
                                CUSheet.show(
                                    VStack {
                                        CLSheetTitle("This is a CUSheetTitle")
                                        CLSheetMenu([
                                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                                CUAlertMessage.show(message: "CUSheetMenuItem tapped")
                                            }, icon: CLIcon(systemImage: "square.and.arrow.up.fill", size: .small, newBadge: text.isEmpty)),
                                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                                CUAlertMessage.show(message: "CUSheetMenuItem tapped")
                                            }),
                                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                                CUAlertMessage.show(message: "CUSheetMenuItem tapped")
                                            }),
                                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                                CUAlertMessage.show(message: "CUSheetMenuItem tapped")
                                            }),
                                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                                CUAlertMessage.show(message: "CUSheetMenuItem tapped")
                                            })
                                        ])
                                    }
                                )
                            }){
                                Text("Test CUSheet with a CUSheetMenu inside")
                            }
                        }
                        .navigationBar("CUSheet()", bigTitle: true)
                    }) {
                        Text("CUSheet()")
                    }
                    
                    NavigationLink(destination: {
                        List {
                            Button(action: {
                                CUAlertMessage.show(message: "This is a normal CUAlertMessage")
                            }){
                                Text("Test CUAlertMessage .normal")
                            }
                            
                            Button(action: {
                                CUAlertMessage.show(message: "This is a error CUAlertMessage", type: .error)
                            }){
                                Text("Test CUAlertMessage .error")
                            }
                        }
                        .navigationBar("CUAlertMessage()", bigTitle: true)
                    }) {
                        Text("CUAlertMessage()")
                    }
                    
                    NavigationLink(destination: {
                        List {
                            Button(action: {
                                CUInAppNotification.show(title: "I'm a CUInAppNotification title", body: "This is my body", tapAction: {
                                    CUAlertMessage.show(message: "CUInAppNotification action tapped")
                                })
                            }){
                                Text("Test CUInAppNotification")
                            }
                        }
                        .navigationBar("CUInAppNotification()", bigTitle: true)
                    }) {
                        Text("CUInAppNotification()")
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
                        ViewPresentationWrapperPage("CLTextEditor()", description: "CLTextEditor() is a multi line text editor which expands on line break. Besides that, CLTextEditor() is able to show hashtags, mentions and links in realtime."){
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
