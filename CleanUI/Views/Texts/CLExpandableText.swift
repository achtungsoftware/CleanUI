//
//  CLExpandableText.swift
//  CleanUI
//
//  Created by Julian Gerhards on 07.10.21.
//

import SwiftUI


/// Returns an ``CLExpandableText`` which has a show more / show less button if the
/// provided string is longer than the characterLimit
public struct CLExpandableText: View {
    
    var string: String
    var characterLimit: Int
    var font: Font
    var richText: Bool
    var foregroundColor: Color
    var alternativeExpandButtonAction: (() -> Void)? = nil
    var attributes: [Attribute]
    
    
    /// - Parameters:
    ///   - string: The String to show
    ///   - characterLimit: The character limit; If the string is longer than the character limit, a show more / show less button gets shown
    ///   - font: The Font
    ///   - richText: Should the Text be an ``CLRichText``?
    ///   - foregroundColor: The Text color
    ///   - alternativeExpandButtonAction: If you provide an action here, the default action for the show more button gets overwritten
    ///   - attributes: The attributes which should be highlighted for the ``CLRichText``, default is [.links, .hashtags, .mentions]
    public init(_ string: String, characterLimit: Int = 150, font: Font = .callout, richText: Bool = true, foregroundColor: Color = Color.defaultText, alternativeExpandButtonAction: (() -> Void)? = nil, attributes: [Attribute] = [.links(), .hashtags(), .mentions()]) {
        self.characterLimit = characterLimit
        self.string = string
        self.font = font
        self.richText = richText
        self.foregroundColor = foregroundColor
        self.alternativeExpandButtonAction = alternativeExpandButtonAction
        self.attributes = attributes
        
        self._shortString = State(initialValue: String(self.string.trim().prefix(characterLimit) + String(self.string.count > self.characterLimit ? "..." : "")))
    }
    
    @State private var shortString: String = ""
    @State private var expanded: Bool = false
    
    public var body: some View {
        VStack(alignment: .leading) {
            if(richText){
                if(expanded || string.count < characterLimit){
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
            
            if(string.count > characterLimit) {
                Button(action: {
                    if(alternativeExpandButtonAction == nil){
                        withAnimation(Animation.easeInOut(duration: 0.2)){
                            expanded.toggle()
                        }
                    }else {
                        alternativeExpandButtonAction!()
                    }
                }) {
                    Text(Language.getStringCleanUI(expanded ? "showless" : "showmore"))
                        .font(font)
                        .foregroundColor(Color.link)
                }
                .buttonStyle(.plain)
                .padding(.vertical, 5)
            }
            
        }
        .onChange(of: string){ value in
            shortString = String(value.trim().prefix(characterLimit) + String(value.count > self.characterLimit ? "..." : ""))
        }
    }
}
