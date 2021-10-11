//
//  CUAlertMessageView.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 11.10.21.
//

import SwiftUI
import CleanUI

struct CUAlertMessageView: View {
    var body: some View {
        List {
            Button(action: {
                CUAlertMessage.show("This is a normal CUAlertMessage with more text than usual", subTitle: "And we got a subTitle !!!")
            }){
                Text("Test CUAlertMessage .normal")
            }
            
            Button(action: {
                CUAlertMessage.show("This is a normal CUAlertMessage")
            }){
                Text("Test CUAlertMessage .normal")
            }
            
            Button(action: {
                CUAlertMessage.show("This is a error CUAlertMessage", type: .error)
            }){
                Text("Test CUAlertMessage .error")
            }
            
            Button(action: {
                CUAlertMessage.show("This is a success CUAlertMessage", type: .success)
            }){
                Text("Test CUAlertMessage .success")
            }
        }
        .navigationBar("CUAlertMessage")
    }
}
