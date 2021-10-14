//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import CleanUI

struct ContentView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        TabView {
            CLNavigationView {
                List {
                    
                    Section(header: CLFeedTitle("Standard")) {
                        NavigationLink(destination: ColorsView()) {
                            Text("Colors")
                        }
                        
                        NavigationLink(destination: {
                            ViewPresentationWrapperPage("CLIcon", description: "CLIcon is a very dynamic and customizable icon representation.", viewToPresent: {
                                CLIconView()
                            })
                        }) {
                            Text("CLIcon")
                        }
                        
                        NavigationLink(destination: CUAlertView()) {
                            Text("CUAlert")
                        }
                        
                        NavigationLink(destination: CUBrowserView()) {
                            Text("CUBrowser")
                        }
                        
                        NavigationLink(destination: CUSheetView()) {
                            Text("CUSheet")
                        }
                        
                        NavigationLink(destination: CUAlertMessageView()) {
                            Text("CUAlertMessage")
                        }
                        
                        NavigationLink(destination: CUInAppNotificationView()) {
                            Text("CUInAppNotification")
                        }
                    }
                }
                .navigationBar("CleanUI Demo", bigTitle: true)
            }
            .tabItem {
                CLIcon(systemImage: "house")
            }
            
            CLNavigationView {
                List {
                    Section(header: CLFeedTitle("Text's")) {
                        NavigationLink(destination: {
                            ViewPresentationWrapperPage("CLRichText", description: "CLRichText is a Text which is able to highlight mentions, hashtags and links. Besides that the highlighted attributes can be tapped with a custom onTapAction."){
                                CLRichText("This is a #RichText! You can also open the Browser knoggl.com. @Mentions are no problem, at all!", attributes: [
                                    .hashtags(onTapAction: { hashtag in
                                        CUAlertMessage.show("You tapped a hashtag! \(hashtag)")
                                    }),
                                    .links(onTapAction: { link in
                                        CUAlertMessage.show("You tapped a link! \(link)")
                                    }),
                                    .mentions(onTapAction: { mention in
                                        CUAlertMessage.show("You tapped a mention! \(mention)")
                                    })
                                ])
                            }
                        }) {
                            Text("CLRichText")
                        }
                    }
                    
                    Section(header: CLFeedTitle("TextEditors")) {
                        NavigationLink(destination: {
                            ViewPresentationWrapperPage("CLSingleLineTextEditor", description: "CLSingleLineTextEditor is a single line text editor which expands on line break. Besides that, CLSingleLineTextEditor is able to show hashtags, mentions and links in realtime."){
                                CLSingleLineTextEditor($text, placeholder: "Placeholder")
                            }
                        }) {
                            Text("CLSingleLineTextEditor")
                        }
                        
                        NavigationLink(destination: {
                            ViewPresentationWrapperPage("CLTextEditor", description: "CLTextEditor is a multi line text editor which expands on line break. Besides that, CLTextEditor is able to show hashtags, mentions and links in realtime."){
                                CLTextEditor($text, placeholder: "Placeholder")
                            }
                        }) {
                            Text("CLTextEditor")
                        }
                    }
                }
                .navigationBar("Text Type Views", bigTitle: true)
            }
            .tabItem {
                CLIcon(systemImage: "textformat")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
