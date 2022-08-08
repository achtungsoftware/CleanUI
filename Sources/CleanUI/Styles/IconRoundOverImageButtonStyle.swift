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

/// IconRoundOverImageButtonStyle: ButtonStyle
public struct IconRoundOverImageButtonStyle: ButtonStyle {
    
    let blackOpacity: Bool
    
    public init(blackOpacity: Bool = true) {
        self.blackOpacity = blackOpacity
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .frame(width: 28, height: 28)
            .if(blackOpacity) { view in
                view
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color.blackOpacity)
                    )
            }
            .if(!blackOpacity) { view in
                view
                    .foregroundColor(.secondary)
                    .background(
                        CLBlurView(.systemMaterialLight)
                            .clipShape(Circle())
                    )
            }
    }
}

struct IconRoundOverImageButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CLUrlImage(urlString: "https://www.tescomaonlineshop.de/files/test.jpg?1566566588", contentMode: .fit)
            
            HStack {
                Button(action: {}){
                    CLIcon(systemImage: "xmark", size: .small)
                }
                .buttonStyle(IconRoundOverImageButtonStyle(blackOpacity: false))
                Button(action: {}){
                    CLIcon(systemImage: "xmark", size: .small)
                }
                .buttonStyle(IconRoundOverImageButtonStyle())
                Button(action: {}){
                    CLIcon(systemImage: "xmark", size: .small)
                }
                .buttonStyle(IconRoundOverImageButtonStyle())
                Button(action: {}){
                    CLIcon(systemImage: "xmark", size: .small)
                }
                .buttonStyle(IconRoundOverImageButtonStyle())
                Button(action: {}){
                    CLIcon(systemImage: "xmark", size: .small)
                }
                .buttonStyle(IconRoundOverImageButtonStyle())
                Button(action: {}){
                    CLIcon(systemImage: "xmark", size: .small)
                }
                .buttonStyle(IconRoundOverImageButtonStyle())
                Button(action: {}){
                    CLIcon(systemImage: "xmark", size: .small)
                }
                .buttonStyle(IconRoundOverImageButtonStyle())
            }
        }
    }
}
