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

/// Returns an ``CLExpandableText`` which has a show more / show less button if the
/// provided string is longer than the `characterLimit`
public struct CLExpandableText: View {
    
    var string: String
    var characterLimit: Int
    var font: Font
    var richText: Bool
    var foregroundColor: Color
    var alternativeExpandButtonAction: (() -> Void)? = nil
    var attributes: [Attribute]
    var expandButtonColor: Color
    
    
    /// - Parameters:
    ///   - string: The `String` to show
    ///   - characterLimit: The character limit; If the `string` is longer than the character limit, a show more / show less button gets shown
    ///   - font: The `Font, default is `.subheadline`
    ///   - richText: Should the Text be an ``CLRichText``?
    ///   - foregroundColor: The Text color
    ///   - alternativeExpandButtonAction: If you provide an action here, the default action for the show more button gets overwritten
    ///   - attributes: The attributes which should be highlighted for the ``CLRichText``, default is `[.links, .hashtags, .mentions]
    ///   - expandButtonColor: Set the foregroundColor for the expand button, default is `Color.grayText`
    public init(_ string: String, characterLimit: Int = 150, font: Font = .subheadline, richText: Bool = true, foregroundColor: Color = Color.defaultText, alternativeExpandButtonAction: (() -> Void)? = nil, attributes: [Attribute] = [.links(), .hashtags(), .mentions()], expandButtonColor: Color = Color.grayText) {
        self.characterLimit = characterLimit
        self.string = string
        self.font = font
        self.richText = richText
        self.foregroundColor = foregroundColor
        self.alternativeExpandButtonAction = alternativeExpandButtonAction
        self.attributes = attributes
        self.expandButtonColor = expandButtonColor
        
        self._shortString = State(initialValue: String(self.string.trim().prefix(characterLimit) + String(self.string.count > self.characterLimit ? "..." : "")))
    }
    
    @State private var shortString: String = ""
    @State private var expanded: Bool = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if richText {
                if expanded || string.count < characterLimit {
                    CLRichText(string, font: font, foregroundColor: foregroundColor, attributes: attributes)
                        .font(font)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }else {
                    CLRichText(shortString, font: font, foregroundColor: foregroundColor, attributes: attributes)
                        .font(font)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }else {
                Text(expanded || string.count < characterLimit ? string : String(string.trim().prefix(characterLimit) + String(string.count > characterLimit ? "..." : "")))
                    .foregroundColor(foregroundColor)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            
            if string.count > characterLimit {
                Button(action: {
                    if(alternativeExpandButtonAction == nil){
                        withAnimation(Animation.easeInOut(duration: 0.2)){
                            expanded.toggle()
                        }
                    }else {
                        alternativeExpandButtonAction!()
                    }
                }) {
                    Text(CULanguage.getStringCleanUI(expanded ? "showless" : "showmore"))
                        .font(font)
                        .foregroundColor(expandButtonColor)
                }
                .buttonStyle(.plain)
            }
            
        }
        .onChange(of: string) { value in
            shortString = String(value.trim().prefix(characterLimit) + String(value.count > self.characterLimit ? "..." : ""))
        }
    }
}

struct CLExpandableText_Previews: PreviewProvider {
    static var previews: some View {
        CLExpandableText("Hallo #knogglHashtag www.knoggl.com @knogglMention", attributes: [
            .links { linkString in
                CUAlertMessage.show("Link: " + linkString)
            },
            .hashtags { hashtagString in
                CUAlertMessage.show("Hashtag: " + hashtagString)
            },
            .mentions { mentionString in
                CUAlertMessage.show("Mention: " + mentionString)
            },
        ])
        .padding()
    }
}
