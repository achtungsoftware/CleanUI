//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// The ``NavigationBarSearchField`` is an ObservableObject model for applying to an ``NavigationBar``
public class NavigationBarSearchField: ObservableObject, Equatable, Identifiable {
    
    public static func == (lhs: NavigationBarSearchField, rhs: NavigationBarSearchField) -> Bool {
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

/// The ``NavigationBar`` modifier applies a ``NavigationBar`` to the view and removes the default UINavigationBar.
/// Use only on ``CLNavigationView``
public struct NavigationBar: ViewModifier {
    
    var title: String
    var subTitle: String
    var bigTitle: Bool
    var customTitle: AnyView?
    var buttons: AnyView?
    @ObservedObject var searchBar: NavigationBarSearchField
    
    /// - Parameters:
    ///   - title: The navigation bar title
    ///   - subTitle: The navigation bar subtitle
    ///   - bigTitle: Should the navigation bar title be big? default is `false
    ///   - customTitle: Lets you apply a custom title view, which replaces the default title
    ///   - buttons: The trailing buttons
    ///   - searchBar: When a ``NavigationBarSearchField`` is applied, the NavigationBar gets a search ability
    public init(title: String, subTitle: String, bigTitle: Bool, customTitle: AnyView?, buttons: AnyView?, searchBar: NavigationBarSearchField?) {
        self.title = title
        self.subTitle = subTitle
        self.buttons = buttons
        self.bigTitle = bigTitle
        self.customTitle = customTitle
        self.searchBar = searchBar ?? NavigationBarSearchField(false)
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
                    if(!searchBarShowSearchResultsWithAnimation){
                        ZStack {
                            HStack {
                                if(isPresentedStatic){
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }){
                                        CLIcon(frameworkImage: "Back_Icon")
                                            .padding(.leading, -8)
                                    }
                                }
                                
                                if(bigTitle && customTitle == nil){
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(title)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                        
                                        if(!subTitle.isEmpty){
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
                            
                            if(!bigTitle){
                                HStack {
                                    Spacer()
                                    if(customTitle != nil){
                                        customTitle
                                    }else {
                                        VStack(spacing: 0) {
                                            Text(title)
                                                .font(.headline)
                                                .lineLimit(1)
                                            if(!subTitle.isEmpty){
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
                            }
                            
                            HStack {
                                Spacer()
                                
                                if buttons != nil || searchBar.isDiscrete {
                                    HStack(spacing: 16) {
                                        Group {
                                            if searchBar.isDiscrete {
                                                Button(action: {
                                                    withAnimation(.easeInOut(duration: 0.25)) {
                                                        searchBar.show.toggle()
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
                        .if(!searchBar.hasSearchBar) { view in
                            view
                                .padding(.bottom, 8)
                        }
                    }
                    
                    if(searchBar.hasSearchBar && !searchBar.isDiscrete || searchBar.isDiscrete && searchBar.show){
                        HStack(spacing: 0) {
                            CLSearchBar(text: $searchBar.query, placeholder: CULanguage.getStringCleanUI("search"), isEditing: $searchBar.isEditing)
                            
                            if(searchBarShowSearchResultsWithAnimation){
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        searchBar.isEditing = false
                                        searchBar.showSearchResults = false
                                        searchBar.query = ""
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
            .background(Color.background)
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
        .onChange(of: searchBar.isEditing) { value in
            withAnimation(.easeInOut(duration: 0.25)) {
                searchBarIsEditingWithAnimation = value
                if(value){
                    searchBar.showSearchResults = true
                }
            }
        }
        .onChange(of: searchBar.showSearchResults) { value in
            withAnimation(.easeInOut(duration: 0.25)) {
                searchBarShowSearchResultsWithAnimation = value
            }
        }
    }
}
