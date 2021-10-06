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
        VStack(spacing: 0) {
            List {
                Text(35521.abbreviate())
                Text(554.abbreviate())
                Text(423546.abbreviate())
                Text(26546546.abbreviate())
                Text(9453.abbreviate())
                Text("Test".md5)
                Text("Hallo&yeay".urlEncode())
                Text("Hallo=yeay".urlEncode())
                Text("Hallo/yeay".urlEncode())
                Text("Hallo?yeay".urlEncode())
            }
        }
        .navigationBar("Test", bigTitle: true, searchBar: NavigationBarSearchField())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
