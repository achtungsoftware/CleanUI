//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// ``CLSearchBar`` is a `UIViewRepresentable` for an `UISearchBar`
public struct CLSearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    @Binding var isEditing: Bool
    
    /// - Parameters:
    ///   - text: The search text
    ///   - placeholder: The placeholder
    ///   - isEditing: A `Binding<Bool>` which indicates if the ``CLSearchBar`` is in focus
    public init(text: Binding<String>, placeholder: String, isEditing: Binding<Bool>) {
        self._text = text
        self.placeholder = placeholder
        self._isEditing = isEditing
    }
    
    public func makeUIView(context: UIViewRepresentableContext<CLSearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<CLSearchBar>) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> CLSearchBar.Coordinator {
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
            CUThreadHelper.async.main.run {
                self.isEditing = true
            }
        }
        
        public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            CUThreadHelper.async.main.run {
                self.isEditing = false
            }
        }
    }
}
