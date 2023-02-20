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


/// The ``NavigationBar`` modifier applies a ``NavigationBar`` to the view and removes the default UINavigationBar.
/// Use only on ``CLNavigationView``
public struct NavigationBar: ViewModifier {
    
    var title: String
    var subTitle: String
    var bigTitle: Bool
    var customTitle: AnyView?
    var buttons: AnyView?
    var backgroundColor: Color
    @ObservedObject var searchField: NavigationBar.SearchField
    
    /// Show a CleanUI ``NavigationBar``
    /// - Parameters:
    ///   - title: The navigation bar title
    ///   - subTitle: The navigation bar subtitle
    ///   - bigTitle: Should the navigation bar title be big? default is `false
    ///   - customTitle: Lets you apply a custom title view, which replaces the default title
    ///   - buttons: The trailing buttons
    ///   - searchField: When a ``NavigationBar.SearchField`` is applied, the
    ///   - backgroundColor: The background color of the navigation bar
    public init(title: String, subTitle: String, bigTitle: Bool, customTitle: AnyView?, buttons: AnyView?, searchField: NavigationBar.SearchField?, backgroundColor: Color) {
        self.title = title
        self.subTitle = subTitle
        self.buttons = buttons
        self.bigTitle = bigTitle
        self.customTitle = customTitle
        self.searchField = searchField ?? NavigationBar.SearchField(false)
        self.backgroundColor = backgroundColor
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchBarIsEditingWithAnimation: Bool = false
    @State private var searchBarShowSearchResultsWithAnimation: Bool = false
    @State private var isPresentedStatic: Bool = false
    
    @State private var showBorder: Bool = false
    
    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            
            
            // Bar
            
            ZStack {
                VStack(spacing: 0) {
                    if !searchBarShowSearchResultsWithAnimation {
                        ZStack {
                            HStack {
                                if isPresentedStatic {
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }){
                                        CLIcon(frameworkImage: "Back_Icon")
                                            .padding(.leading, -8)
                                    }
                                }
                                
                                if bigTitle && customTitle == nil {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(title)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                        
                                        if !subTitle.isEmpty {
                                            Text(subTitle)
                                                .font(.caption2)
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.grayText)
                                                .lineLimit(1)
                                            
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                            
                            if !bigTitle {
                                HStack {
                                    if customTitle != nil {
                                        customTitle
                                    }else {
                                        Spacer()
                                        
                                        VStack(spacing: 0) {
                                            Text(title)
                                                .font(.headline)
                                                .lineLimit(1)
                                            if !subTitle.isEmpty {
                                                Text(subTitle)
                                                    .font(.caption2)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(Color.grayText)
                                                    .lineLimit(1)
                                                
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                }
                            }
                            
                            HStack {
                                Spacer()
                                
                                if buttons != nil || searchField.isDiscrete {
                                    HStack(spacing: 16) {
                                        Group {
                                            if searchField.isDiscrete {
                                                Button(action: {
                                                    withAnimation(.easeInOut(duration: 0.25)) {
                                                        searchField.show.toggle()
                                                    }
                                                }){
                                                    CLIcon(frameworkImage: "Search_Icon", size: .small)
                                                }
                                            }
                                            
                                            if buttons != nil {
                                                buttons
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 12)
                        .padding(.horizontal)
                        .if(!searchField.hasSearchBar) { view in
                            view
                                .padding(.bottom, 8)
                        }
                    }
                    
                    if searchField.hasSearchBar && !searchField.isDiscrete || searchField.isDiscrete && searchField.show {
                        HStack(spacing: 0) {
                            CLSearchBar(text: $searchField.query, placeholder: CULanguage.getStringCleanUI("search"), isEditing: $searchField.isEditing)
                            
                            if searchBarShowSearchResultsWithAnimation {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        searchField.isEditing = false
                                        searchField.showSearchResults = false
                                        searchField.query = ""
                                    }
                                    
                                    // Close Keyboard
                                    UIApplication.shared.endEditing()
                                }){
                                    Text(CULanguage.getStringCleanUI("cancel"))
                                }
                                .padding(.leading, 8)
                                .padding(.trailing)
                            }
                        }
                        .padding(.horizontal, 8)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: nil, alignment: .topLeading)
            .background(backgroundColor)
            .overlay(
                VStack {
                    Spacer()
                    Divider()
                        .frame(height: 0.4)
                        .opacity(showBorder ? 0.7 : 0)
                }
            )
            .onAppear {
                isPresentedStatic = presentationMode.wrappedValue.isPresented
            }
            
            
            // Bar
            
            
            ZStack {
                
                // Expand view fullscreen
                Color.clear.edgesIgnoringSafeArea(.all)
                
                CLScrollOffsetReader(offsetChanged: { offset in
                    if let offset = offset {
                        if offset.y > 10 {
                            if !showBorder {
                                showBorder = true
                            }
                        }else {
                            if showBorder {
                                showBorder = false
                            }
                        }
                    }else {
                        showBorder = true
                    }
                }) {
                    content
                }
            }
        }
        .hideNavigationBar()
        .onChange(of: searchField.isEditing) { value in
            withAnimation(.easeInOut(duration: 0.25)) {
                searchBarIsEditingWithAnimation = value
                if value {
                    searchField.showSearchResults = true
                }
            }
        }
        .onChange(of: searchField.showSearchResults) { value in
            withAnimation(.easeInOut(duration: 0.25)) {
                searchBarShowSearchResultsWithAnimation = value
            }
        }
    }
}

extension NavigationBar {    
    /// The ``NavigationBar.SearchField`` is an ObservableObject model for applying to an ``NavigationBar``
    public class SearchField: ObservableObject, Equatable, Identifiable {
        
        public static func == (lhs: SearchField, rhs: SearchField) -> Bool {
            lhs.id == rhs.id
        }
        
        public let id = UUID()
        
        @Published public var isEditing: Bool = false
        @Published public var showSearchResults: Bool = false
        @Published public var query: String = ""
        @Published public var show: Bool = false
        var hasSearchBar: Bool
        var isDiscrete: Bool
        
        /// - Parameters:
        ///   - hasSearchBar: If false, the ``NavigationBar`` acts like it has no search field, default is true
        ///   - isDiscrete: When this is true, the ``NavigationBar`` gets a search button which needs to be pressed for the search bar to unhide, default is false
        public init(_ hasSearchBar: Bool = true, isDiscrete: Bool = false){
            self.hasSearchBar = hasSearchBar
            self.isDiscrete = isDiscrete
        }
    }
}

public extension View {
    /// Show a CleanUI ``NavigationBar``
    /// - Parameters:
    ///   - title: The navigation bar title
    ///   - subTitle: The navigation bar subtitle
    ///   - bigTitle: Should the navigation bar title be big? default is `false
    ///   - customTitle: Lets you apply a custom title view, which replaces the default title
    ///   - buttons: The trailing buttons
    ///   - searchField: When a ``NavigationBar.SearchField`` is applied, the NavigationBar gets a search ability
    func navigationBar(_ title: String = "", subTitle: String = "", bigTitle: Bool = false, customTitle: AnyView? = nil, buttons: AnyView? = nil, searchField: NavigationBar.SearchField? = nil, backgroundColor: Color = Color.background) -> some View {
        modifier(NavigationBar(title: title, subTitle: subTitle, bigTitle: bigTitle, customTitle: customTitle, buttons: buttons, searchField: searchField, backgroundColor: backgroundColor))
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Text("Default")
            }
            .navigationBar("Default")
        }
        
        NavigationView {
            List {
                Text("Big")
            }
            .navigationBar("Big", bigTitle: true)
        }
        
        NavigationView {
            List {
                Text("With Subtitle")
            }
            .navigationBar("With Subtitle", subTitle: "Subtitle")
        }
        
        NavigationView {
            List {
                Text("With SearchField")
            }
            .navigationBar("With SearchField", searchField: NavigationBar.SearchField())
        }
        
        NavigationView {
            List {
                Text("With SearchField")
            }
            .navigationBar(customTitle: AnyView(
                HStack {
                    Text("Hallo Custom")
                    Spacer()
                }
            ))
        }
    }
}
