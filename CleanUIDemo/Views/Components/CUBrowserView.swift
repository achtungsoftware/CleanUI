//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
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
