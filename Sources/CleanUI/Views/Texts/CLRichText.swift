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

/// Returns a ``CLRichText`` with ``Attribute`` highlighting and onTap actions
public struct CLRichText: View {
    
    var string: String
    var font: Font
    var foregroundColor: Color
    var attributes: [Attribute]
    
    /// - Parameters:
    ///   - string: The String that should be shown
    ///   - font: The `Font`, default is `.subheadline`
    ///   - foregroundColor: The text color, default is `Color.defaultText`
    ///   - attributes: The attributes which should be highlighted, default is `[.links, .hashtags, .mentions]
    public init(_ string: String, font: Font = .subheadline, foregroundColor: Color = Color.defaultText, attributes: [Attribute] = [.links(), .hashtags(), .mentions()]){
        self.string = string
        self.font = font
        self.foregroundColor = foregroundColor
        self.attributes = attributes
    }
    
    @StateObject private var textViewStore = TextViewStore()
    
    public var body: some View {
        Text(string)
            .foregroundColor(Color.clear)
            .font(font)
            .fixedSize(horizontal: false, vertical: true)
            .overlay(
                GeometryReader { geometry in
                    TextViewOverlay(string: string, font: font, maxLayoutWidth: geometry.maxWidth, textViewStore: textViewStore, foregroundColor: foregroundColor, attributes: attributes)
                        .frame(height: textViewStore.height)
                }
                    .frame(height: textViewStore.height)
            )
    }
}

internal extension CLRichText {
    struct TextViewOverlay: UIViewRepresentable {
        
        var string: String
        var font: Font
        var maxLayoutWidth: CGFloat
        var textViewStore: TextViewStore
        var foregroundColor: Color
        var attributes: [Attribute]
        
        @State var attributedText = NSMutableAttributedString()
        let textView = TextView()
        
        func makeUIView(context: Context) -> TextView {
            
            // Add tap gesture recognizer to TextView
            let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.onTap(_:)))
            tap.delegate = context.coordinator
            textView.addGestureRecognizer(tap)
            
            textView.delegate = context.coordinator
            
            textView.font = font.toUIFont()
            textView.isSelectable = true
            textView.isUserInteractionEnabled = true
            textView.isEditable = false
            textView.isScrollEnabled = false
            textView.backgroundColor = .clear
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0
            textView.adjustsFontForContentSizeCategory = true
            textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            
            return textView
        }
        
        func updateUIView(_ uiView: TextView, context: Context) {
            attributedText.mutableString.setString(string)
            
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(foregroundColor), range: NSRange(location: 0, length: attributedText.length))
            attributedText.addAttribute(NSAttributedString.Key.font, value: font.toUIFont(), range: NSRange(location: 0, length: attributedText.length))
            
            
            for attribute in attributes {
                switch attribute {
                case .links(_):
                    let links = string.getLinks()
                    
                    for (foundedLink, range) in links {
                        var multipleAttributes = [NSAttributedString.Key : Any]()
                        multipleAttributes[NSAttributedString.Key.customLink] = foundedLink
                        multipleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.defaultLink
                        attributedText.addAttributes(multipleAttributes, range: range)
                    }
                case .hashtags(_):
                    let hashtags = string.getHashtags()
                    
                    for (foundedHashtag, range) in hashtags {
                        var multipleAttributes = [NSAttributedString.Key : Any]()
                        multipleAttributes[NSAttributedString.Key.hashtag] = foundedHashtag.dropFirst()
                        multipleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.defaultLink
                        attributedText.addAttributes(multipleAttributes, range: range)
                    }
                case .mentions(_):
                    let mentions = string.getMentions()
                    
                    for (foundedMention, range) in mentions {
                        var multipleAttributes = [NSAttributedString.Key : Any]()
                        multipleAttributes[NSAttributedString.Key.mention] = foundedMention.dropFirst()
                        multipleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.defaultLink
                        attributedText.addAttributes(multipleAttributes, range: range)
                    }
                }
            }
            
            uiView.attributedText = attributedText
            uiView.maxLayoutWidth = maxLayoutWidth
            textViewStore.didUpdateTextView(uiView)
        }
        
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(self)
        }
        
        final class Coordinator: NSObject, UITextViewDelegate, UIGestureRecognizerDelegate {
            
            var parent: TextViewOverlay
            var heightSet: Bool = false
            
            init(_ parent: TextViewOverlay) {
                self.parent = parent
            }
            
            @objc func onTap(_ sender: UITapGestureRecognizer) {
                let textView = sender.view as! UITextView
                let layoutManager = textView.layoutManager
                
                // location of tap in textView coordinates and taking the inset into account
                var location = sender.location(in: textView)
                location.x -= textView.textContainerInset.left
                location.y -= textView.textContainerInset.top
                
                // character index at tap location
                let characterIndex = layoutManager.characterIndex(for: location, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
                
                // if index is valid then do something.
                if characterIndex < textView.textStorage.length {
                    
                    // Tap on Link
                    let linkAttribute = NSAttributedString.Key.customLink
                    let linkAttributeValue = textView.attributedText?.attribute(linkAttribute, at: characterIndex, effectiveRange: nil)
                    if let linkValue = linkAttributeValue {
                        for attribute in parent.attributes {
                            switch attribute {
                            case .links(let action):
                                if let action = action {
                                    action(linkValue as? String ?? "")
                                }
                            default:
                                break
                            }
                        }
                    }
                    
                    // Tap on Mention
                    let mentionAttribute = NSAttributedString.Key.mention
                    let mentionAttributeValue = textView.attributedText?.attribute(mentionAttribute, at: characterIndex, effectiveRange: nil)
                    if let mentionValue = mentionAttributeValue {
                        for attribute in parent.attributes {
                            switch attribute {
                            case .mentions(let action):
                                if let action = action {
                                    action(mentionValue as? String ?? "")
                                }
                            default:
                                break
                            }
                        }
                    }
                    
                    // Tap on Hashtag
                    let hashtagAttribute = NSAttributedString.Key.hashtag
                    let hashtagAttributeValue = textView.attributedText?.attribute(hashtagAttribute, at: characterIndex, effectiveRange: nil)
                    if let hashtagValue = hashtagAttributeValue {
                        for attribute in parent.attributes {
                            switch attribute {
                            case .hashtags(let action):
                                if let action = action {
                                    action(hashtagValue as? String ?? "")
                                }
                            default:
                                break
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

struct CLRichText_Previews: PreviewProvider {
    static var previews: some View {
        CLRichText("Hallo #knogglHashtag www.knoggl.com @knogglMention", attributes: [
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
