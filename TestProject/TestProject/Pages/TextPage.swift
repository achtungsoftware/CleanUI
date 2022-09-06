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
import CleanUI

struct TextPage: View {
    
    @State private var text: String = "Hello @CleanUI, we love #Knoggl -> visit knoggl.com!"
    
    var body: some View {
        List {
            NavigationLink("CLRichText", destination: richTextPage)
        }
        .navigationTitle("Text")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var richTextPage: some View {
        List {
            CLRichText(text, attributes: [
                .hashtags { hashtagString in
                    CUAlertMessage.show("Tapped on Hashtag!", subTitle: hashtagString)
                },
                .links { linkString in
                    CUAlertMessage.show("Tapped on Link!", subTitle: linkString)
                },
                .mentions { mentionString in
                    CUAlertMessage.show("Tapped on Mention!", subTitle: mentionString)
                }
            ])
        }
        .navigationTitle("CLRichText")
        .navigationBarTitleDisplayMode(.inline)
    }
}
