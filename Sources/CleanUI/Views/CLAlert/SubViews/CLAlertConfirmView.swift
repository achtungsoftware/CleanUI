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
