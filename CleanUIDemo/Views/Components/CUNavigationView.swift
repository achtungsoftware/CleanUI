//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import CleanUI

struct CUNavigationView: View {
    
    var body: some View {
        List {
            Button(action: {
                CUNavigation.popToRootView()
            }){
                Text("CUNavigation.popToRootView()")
            }
            
            Button(action: {
                CUNavigation.pushToSwiftUiView(Text("DetailPage"))
            }){
                Text("CUNavigation.pushToSwiftUiView(Text(\"DetailPage\"))")
            }
            
            Button(action: {
                CUNavigation.pushBottomSheet(Text("DetailPage"))
            }){
                Text("CUNavigation.pushBottomSheet(Text(\"DetailPage\"))")
            }
        }
        .navigationBar("CUNavigation")
    }
}
