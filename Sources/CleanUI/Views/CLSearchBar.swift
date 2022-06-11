//  Copyright © 2021 - present Julian Gerhards
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine
import SwiftPlus

/// ``CLSearchBar`` is a `UIViewRepresentable` for an `UISearchBar`
public struct CLSearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    @Binding var isEditing: Bool
    let becomeFirstResponder: Bool
    let onSubmit: () -> Void
    
    /// - Parameters:
    ///   - text: The search text
    ///   - placeholder: The placeholder
    ///   - isEditing: A `Binding<Bool>` which indicates if the ``CLSearchBar`` is in focus
    ///   - becomeFirstResponder: Should this `UISearchBar` automatically focus?, default is `false`
    public init(text: Binding<String>, placeholder: String, isEditing: Binding<Bool>, becomeFirstResponder: Bool = false, onSubmit: @escaping () -> Void = {}) {
        self._text = text
        self.placeholder = placeholder
        self._isEditing = isEditing
        self.becomeFirstResponder = becomeFirstResponder
        self.onSubmit = onSubmit
    }
    
    public func makeUIView(context: UIViewRepresentableContext<CLSearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        
        if becomeFirstResponder {
            searchBar.becomeFirstResponder()
        }
        
        return searchBar
    }
    
    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<CLSearchBar>) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> CLSearchBar.Coordinator {
        return Coordinator(self, text: $text, isEditing: $isEditing)
    }
    
    public class Coordinator: NSObject, UISearchBarDelegate {
        
        let parent: CLSearchBar
        @Binding var text: String
        @Binding var isEditing: Bool
        
        init(_ parent: CLSearchBar, text: Binding<String>, isEditing: Binding<Bool>) {
            self.parent = parent
            _text = text
            _isEditing = isEditing
        }
        
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            parent.onSubmit()
        }
        
        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            SPThreadHelper.async.main.run {
                self.isEditing = true
            }
        }
        
        public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            SPThreadHelper.async.main.run {
                self.isEditing = false
            }
        }
    }
}

struct CLSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CLSearchBar(text: Binding.constant(""), placeholder: "Placeholder", isEditing: Binding.constant(false))
    }
}
