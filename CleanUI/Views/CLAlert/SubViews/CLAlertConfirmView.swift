//
//  Copyright © 2021 - present CleanUI (Julian Gerhards)
//
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// ``CLAlertConfirmView`` is a action confirmation view for ``CUAlert``
public struct CLAlertConfirmView: View {
    
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
        VStack(spacing: 16) {
            VStack {
                Text(title)
                    .font(.title3.bold())
                    .padding(.bottom, 8)
                
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .font(.subheadline)
                }
            }
            
            Divider()
            
            HStack {
                Button(action: {
                    CUAlert.clearAll()
                }, label: {
                    Text(CULanguage.getStringCleanUI("cancel"))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 5)
                })
                
                Divider()
                    .frame(height: 25)
                
                Button(action: {
                    confirmAction()
                    CUAlert.clearAll()
                }, label: {
                    Text(CULanguage.getStringCleanUI("continue"))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 5)
                })
            }
            .font(.subheadline)
            .foregroundColor(Color.defaultText)
        }
    }
}
