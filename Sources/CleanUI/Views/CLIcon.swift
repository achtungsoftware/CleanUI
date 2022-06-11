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

/// Returns a very dynamic and customizable ``CLIcon``
public struct CLIcon: View {
    
    var image: String
    var systemImage: String
    var frameworkImage: String
    var newBadge: Bool?
    var size: CLIcon.Size
    var isImageOverlay: Bool
    var offset: CLIcon.Offset
    var tapAction: (() -> Void)?
    
    /// - Parameters:
    ///   - image: Image name from asset catalog
    ///   - systemImage: System image name
    ///   - frameworkImage: The Image name from the CleanUI frameworks asset catalog
    ///   - size: The ``CLIcon`` size, default is `.medium`
    ///   - newBadge: Should a ``CLNewBadge`` overlay the Icon?
    ///   - isImageOverlay: If true the ``CLIcon`` gets a shadow for better readability
    ///   - offset: Define an offset for the ``CLIcon``, default is none -> `.leading(0)`
    ///   - tapAction: If a tap action is provided, the CLIcon becomes a ``Button``, default is nil
    public init(_ image: String = "", systemImage: String = "", frameworkImage: String = "", size: CLIcon.Size = .medium, newBadge: Bool? = nil, isImageOverlay: Bool = false, offset: CLIcon.Offset = .leading(0), tapAction: (() -> Void)? = nil){
        self.image = image
        self.size = size
        self.systemImage = systemImage
        self.newBadge = newBadge
        self.isImageOverlay = isImageOverlay
        self.offset = offset
        self.frameworkImage = frameworkImage
        self.tapAction = tapAction
        
        self._sideSize = State(initialValue: self.size == .small ? 22 : self.size == .medium ? 26 : self.size == .textSize ? 16 : 30)
    }
    
    @State var sideSize: CGFloat = 0
    
    public var body: some View {
        if let tapAction = tapAction {
            Button(action: tapAction) {
                icon
            }
            .buttonStyle(.plain)
        }else {
            icon
        }
    }
    
    private var icon: some View {
        ZStack {
            if !image.isEmpty {
                Image(image)
                    .resizable()
                    .frame(width: sideSize, height: sideSize)
                    .if(isImageOverlay) { view in
                        view
                            .defaultShadow()
                    }
            }else if !frameworkImage.isEmpty {
                ImageProvider.image(frameworkImage)
                    .resizable()
                    .frame(width: sideSize, height: sideSize)
                    .if(isImageOverlay) { view in
                        view
                            .defaultShadow()
                    }
            } else {
                Image(systemName: systemImage)
                    .font(.system(size: systemImage != "" ? sideSize - 4 : sideSize))
                    .if(isImageOverlay) { view in
                        view
                            .defaultShadow()
                    }
            }
            
            if newBadge != nil && newBadge! {
                CLNewBadge()
                    .offset(x: sideSize / 3, y: -sideSize / 3)
            }
        }
        .offset(offset.toCGSize())
    }
}

public extension CLIcon {
    enum Size {
        case textSize, small, medium, large
    }
    
    enum Offset {
        case leading(Double), trailing(Double), bottom(Double), top(Double)
    }
}

internal extension CLIcon.Offset {
    
    /// Converts the ``CLIcon.Offset`` to a `CGSize`
    /// - Returns: The offset as `CGSize`
    func toCGSize() -> CGSize {
        switch self {
        case .leading(let of):
            return CGSize(width: of, height: 0)
        case .trailing(let of):
            return CGSize(width: -of, height: 0)
        case .bottom(let of):
            return CGSize(width: 0, height: -of)
        case .top(let of):
            return CGSize(width: 0, height: of)
        }
    }
}

struct CLIcon_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CLIcon(systemImage: "clock", size: .textSize)
            CLIcon(systemImage: "clock", size: .small)
            CLIcon(systemImage: "clock", size: .medium)
            CLIcon(systemImage: "clock", size: .large)
            CLIcon(systemImage: "clock", newBadge: true, offset: .trailing(16))
            
            CLIcon(systemImage: "clock", newBadge: true) {
                CUAlertMessage.show("Tapped")
            }
        }
    }
}
