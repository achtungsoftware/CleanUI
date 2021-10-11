//
//  CUAlertView.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 11.10.21.
//

import SwiftUI
import CleanUI

struct CUAlertView: View {
    
    @State private var text: String = ""
    var body: some View {
        List {
            Button(action: {
                CUAlert.show(Text("This is just a Text!"))
            }){
                Text("Test CUAlert with Text inside")
            }
            
            Button(action: {
                CUAlert.show(CLAlertConfirmView("This is a title", subTitle: "This is a subtitle", confirmAction: {
                    CUAlertMessage.show("Action tapped")
                }))
            }){
                Text("Test CUAlert with CLAlertConfirmView inside")
            }
            
            Button(action: {
                CUAlert.show(
                    VStack {
                        Text("Type something")
                            .font(.headline)
                        
                        CLSingleLineTextEditor($text, placeholder: "This is a CLSingleLineTextEditor")
                        
                        Button(action: {
                            CUAlert.clearAll()
                            CUAlertMessage.show("You entered the following text", subTitle: text)
                            text = ""
                        }){
                            Text("This is a Button")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                )
            }){
                Text("Test CUAlert with CLSingleLineTextEditor, a Button and a title inside")
            }
        }
        .navigationBar("CUAlert")
    }
}
