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

/// ``InfoCardManagerModel`` manages the ``CLInfoCardManager``
public class InfoCardManagerModel: ObservableObject {
    
    @Published var isVisible: Bool = false
    @Published var title: String = ""
    @Published var subTitle: String = ""
    @Published var type: CLInfoCard.InfoCardType = .info
    
    public init() {}
    
    /// Shows a new ``CLInfoCard` or replaces the old one with animation
    /// - Parameters:
    ///   - title: The main text to display inside the card
    ///   - subTitle: The secondary text to display inside the card
    ///   - type: The ``CLInfoCard/InfoCardType``, default is `.info`
    public func show(_ title: String, subTitle: String = "", type: CLInfoCard.InfoCardType = .info) {
        withAnimation {
            self.title = title
            self.subTitle = subTitle
            self.type = type
            self.isVisible = true
        }
    }
    
    /// Hides all InfoCards with animation
    public func hide(){
        withAnimation {
            self.isVisible = false
        }
    }
}

/// Returns a view which is able to decide if and which ``CLInfoCard`` should be displayed based on a ``InfoCardManagerModel``
public struct CLInfoCardManager: View {
    
    @ObservedObject var manager: InfoCardManagerModel
    
    /// - Parameter manager: Needs a ``InfoCardManagerModel`` for managing the CLInfoCard
    public init(_ manager: InfoCardManagerModel) {
        self.manager = manager
    }
    
    public var body: some View {
        Group {
            if manager.isVisible {
                CLInfoCard(manager.title, subTitle: manager.subTitle, type: manager.type)
            }else {
                EmptyView()
            }
        }
    }
}

/// Returns a view, in style of a card with text for information. If there is the possibility that multiple ``CLInfoCard``'s
/// gets shown, consider using a ``CLInfoCardManager`` instead.
public struct CLInfoCard: View {
    
    public enum InfoCardType {
        case error, success, info
    }
    
    var title: String
    var subTitle: String
    var type: InfoCardType
    
    /// - Parameters:
    ///   - title: The main Text to display inside the card
    ///   - subTitle: The secondary Text to display inside the card
    ///   - type: The ``InfoCardType``, default is `.info`
    public init(_ title: String, subTitle: String = "", type: InfoCardType = .info) {
        self.title = title
        self.subTitle = subTitle
        self.type = type
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.callout.bold())
                
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .font(.caption)
                        .foregroundColor(Color.grayText)
                }
            }
            .padding(8)
            .padding(.leading, 10)
        }
        .foregroundColor(Color.defaultText)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(
            Color.alert
        )
        .overlay(
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(Color.defaultBorder, lineWidth: 0.3)
                    .opacity(0.5)
                
                Rectangle()
                    .fill(type == .error ? Color.defaultRed : type == .info ? Color.primaryColor : Color.green)
                    .frame(width: 10)
            }
        )
        .cornerRadius(6)
    }
}

struct CLInfoCard_Previews: PreviewProvider {
    static let text: String = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"
    static var previews: some View {
        VStack {
            CLInfoCard("Info", subTitle: text)
            CLInfoCard("Info", subTitle: text, type: .error)
            CLInfoCard("Info", subTitle: text, type: .success)
        }
        .padding()
    }
}
