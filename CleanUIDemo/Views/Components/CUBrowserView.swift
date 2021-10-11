//
//  CUBrowserView.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 11.10.21.
//

import SwiftUI
import CleanUI

struct CUBrowserView: View {
    var body: some View {
        List {
            Button(action: {
                CUBrowser.open("https://www.knoggl.com")
            }){
                Text("Open knoggl.com")
            }
        }
        .navigationBar("CUBrowser")
    }
}
