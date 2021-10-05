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
                
            }
            .listStyle(.plain)
        }
        .padding()
        .navigationBar("Test", bigTitle: true, searchBar: NavigationBarSearchField())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
