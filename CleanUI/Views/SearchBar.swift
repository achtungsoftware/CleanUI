//
//  SearchBar.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// ``SearchBar`` is a UIViewRepresentable for an UISearchBar
public struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    @Binding var isEditing: Bool
    
    /// - Parameters:
    ///   - text: The search text
    ///   - placeholder: The placeholder
    ///   - isEditing: A Binding<Bool> which indicates if the SearchBar is in focus
    init(text: Binding<String>, placeholder: String, isEditing: Binding<Bool>) {
        self._text = text
        self.placeholder = placeholder
        self._isEditing = isEditing
    }
    
    public func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, isEditing: $isEditing)
    }
    
    public class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        @Binding var isEditing: Bool
        
        init(text: Binding<String>, isEditing: Binding<Bool>) {
            _text = text
            _isEditing = isEditing
        }
        
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            ThreadHelper.async.main.run {
                self.isEditing = true
            }
        }
        
        public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            ThreadHelper.async.main.run {
                self.isEditing = false
            }
        }
    }
}
