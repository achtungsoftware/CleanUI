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
            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .font(.subheadline)
                        .foregroundColor(.grayText)
                }
            }
            
            VStack(spacing: 8) {
                Button(action: {
                    CUAlert.clearAll()
                }) {
                    Text(CULanguage.getStringCleanUI("cancel"))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.knogglSecondaryAlternative)
                
                Button(action: {
                    confirmAction()
                    CUAlert.clearAll()
                }) {
                    Text(CULanguage.getStringCleanUI("continue"))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.knogglSecondary)
            }
            .font(.subheadline)
            .foregroundColor(Color.defaultText)
        }
    }
}

struct CLAlertConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        CLAlert(content: CLAlertConfirmView("This is a Title", subTitle: "This is aSubtitle", confirmAction: {}))
            .background(.gray)
    }
}
