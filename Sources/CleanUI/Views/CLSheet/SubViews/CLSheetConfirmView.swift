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
            .buttonStyle(.knogglAlternative)
            
            Button(action: {
                confirmAction()
                CUSheet.clearAll()
            }) {
                Text(CULanguage.getStringCleanUI("continue"))
            }
            .buttonStyle(.knoggl)
        }
        .padding()
        .foregroundColor(Color.defaultText)
    }
}

struct CLSheetConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        CLSheetConfirmView("Title", subTitle: "Subtitle") {
            CUAlertMessage.show("Tapped")
        }
    }
}
