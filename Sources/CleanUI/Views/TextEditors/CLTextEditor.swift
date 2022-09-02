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

/// Returns a ``CLTextEditor`` with ``Attribute`` highlighting, character limit, and placeholder
public struct CLTextEditor: View {
    
    @Binding var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType
    var minHeight: CGFloat
    var characterLimit: Int
    var attributes: [Attribute]
    
    /// - Parameters:
    ///   - text: The text to modify
    ///   - placeholder: The placeholder
    ///   - keyboardType: The keyboard type, default is `.twitter`
    ///   - minHeight: The minimum height for the TextEditor, default is `90`
    ///   - characterLimit: The character limit which the user is allowed to type. 0 means no limit, default is `0`
    ///   - attributes: The attributes which should be highlighted, default is `[.links, .hashtags, .mentions]`
    public init(_ text: Binding<String>, placeholder: String = "", keyboardType: UIKeyboardType = .twitter, minHeight: CGFloat = 90, characterLimit: Int = 0, attributes: [Attribute] = [.links(), .hashtags(), .mentions()]){
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.minHeight = minHeight
        self.characterLimit = characterLimit
        self.attributes = attributes
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    @StateObject private var textViewStore = TextViewStore()
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.clear)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .allowsHitTesting(false)
                .frame(minHeight: minHeight, alignment: .topLeading)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .opacity(0.6)
                    .allowsHitTesting(false)
            }
        }
        .font(.callout)
        .overlay(
            GeometryReader { geometryReader in
                TextViewOverlay(text: $text, font: .callout, maxLayoutWidth: geometryReader.maxWidth, textViewStore: textViewStore, keyboardType: keyboardType, attributes: attributes)
            }
        )
        .onChange(of: text) { value in
            if characterLimit != 0 {
                if value.count > characterLimit {
                    DispatchQueue.main.async {
                        text = String(text.dropLast(value.count - characterLimit))
                    }
                }
            }
        }
    }
}

struct TextViewOverlay: UIViewRepresentable {
    
    @Binding var text: String
    var font: Font
    var maxLayoutWidth: CGFloat
    var textViewStore: TextViewStore
    var keyboardType: UIKeyboardType
    var isScrollEnabled: Bool = false
    var attributes: [Attribute]
    
    let textView = TextView()
    @State var attributedText = NSMutableAttributedString()
    
    func makeUIView(context: Context) -> TextView {
        textView.delegate = context.coordinator
        
        textView.font = font.toUIFont()
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        textView.isScrollEnabled = isScrollEnabled
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.keyboardType = keyboardType
        textView.textContainer.lineFragmentPadding = 0
        textView.adjustsFontForContentSizeCategory = true
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return textView
    }
    
    func updateUIView(_ uiView: TextView, context: Context) {
        DispatchQueue.main.async {
            attributedText.mutableString.setString(text)
            
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(Color.defaultText), range: NSRange(location: 0, length: attributedText.length))
            attributedText.addAttribute(NSAttributedString.Key.font, value: font.toUIFont(), range: NSRange(location: 0, length: attributedText.length))
            
            for attribute in attributes {
                switch attribute {
                case .links(_):
                    let links = text.getLinks()
                    
                    for (_, range) in links {
                        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.defaultLink, range: range)
                    }
                case .hashtags(_):
                    let hashtags = text.getHashtags()
                    
                    for (_, range) in hashtags {
                        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.defaultLink, range: range)
                    }
                case .mentions(_):
                    let mentions = text.getMentions()
                    
                    for (_, range) in mentions {
                        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.defaultLink, range: range)
                    }
                }
            }
            
            uiView.textStorage.setAttributedString(attributedText)
            uiView.maxLayoutWidth = maxLayoutWidth
            textViewStore.didUpdateTextView(uiView)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewOverlay
        
        init(_ parent: TextViewOverlay) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if parent.text != textView.attributedText.string {
                parent.text = textView.attributedText.string
            }
        }
    }
}

class TextView: UITextView {
    var maxLayoutWidth: CGFloat = 0 {
        didSet {
            guard maxLayoutWidth != oldValue else { return }
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        guard maxLayoutWidth > 0 else {
            return super.intrinsicContentSize
        }
        
        return sizeThatFits(
            CGSize(width: maxLayoutWidth, height: .greatestFiniteMagnitude)
        )
    }
}

class TextViewStore: ObservableObject {
    
    @Published var height: CGFloat?
    var heightSet: Bool = false
    
    func didUpdateTextView(_ textView: TextView) {
        if !heightSet {
            height = textView.intrinsicContentSize.height
            heightSet = true
        }
    }
}

struct CLTextEditorPreview: View {
    @State var text = ""
    var body: some View {
        VStack {
            CLTextEditor($text, placeholder: "Hallo, Welt!")
                .background(.gray.opacity(0.2))
        }
    }
}

struct CLTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScrollView {
                CLTextEditorPreview()
            }
            
            Text("Footer")
        }
    }
}
