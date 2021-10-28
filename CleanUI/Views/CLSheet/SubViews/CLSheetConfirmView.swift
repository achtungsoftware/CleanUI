//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// ``CLSheetConfirmView`` is a action confirmation view for ``CUSheet``
public struct CLSheetConfirmView: View {
    
    var title: String
    var subTitle: String
    var confirmAction: () -> Void
    
    /// - Parameters:
    ///   - title: The title `String`
    ///   - subTitle: The optional sub title `String`
    ///   - confirmAction: The action for the continue button
    public init(_ title: String, subTitle: String = "", confirmAction: @escaping () -> Void) {
        self.title = title
        self.subTitle = subTitle
        self.confirmAction = confirmAction
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .center) {
                Text(title)
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom)
            
            Button(action: {
                CUSheet.clearAll()
            }) {
                Text(CULanguage.getStringCleanUI("cancel"))
            }
            .buttonStyle(PrimaryButtonStyle(buttonTheme: .secondary))
            
            Button(action: {
                confirmAction()
                CUSheet.clearAll()
            }) {
                Text(CULanguage.getStringCleanUI("continue"))
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .foregroundColor(Color.defaultText)
    }
}
