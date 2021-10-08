//
//  CLIcon.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// Returns a very dynamic and customizable ``CLIcon``
public struct CLIcon: View {
    
    public enum Size {
        case textSize, small, medium, large
    }
    
    public enum Offset {
        case leading(CGFloat), trailing(CGFloat), bottom(CGFloat), top(CGFloat)
    }
    
    var image: String
    var systemImage: String
    var frameworkImage: String
    var newBadge: Bool?
    var size: CLIcon.Size
    var isImageOverlay: Bool
    var offset: CLIcon.Offset
    
    @State var sideSize: CGFloat = 0
    
    /// - Parameters:
    ///   - image: Image name from asset catalog
    ///   - systemImage: System image name
    ///   - frameworkImage: The Image name from the CleanUI frameworks asset catalog
    ///   - size: The ``CLIcon`` size, default is `.medium`
    ///   - newBadge: Should a ``CLNewBadge`` overlay the Icon?
    ///   - isImageOverlay: If true the ``CLIcon`` gets a shadow for better readability
    ///   - offset: Define an offset for the ``CLIcon``, default is none -> `.leading(0)`
    public init(_ image: String = "", systemImage: String = "", frameworkImage: String = "", size: CLIcon.Size = .medium, newBadge: Bool? = nil, isImageOverlay: Bool = false, offset: CLIcon.Offset = .leading(0)){
        self.image = image
        self.size = size
        self.systemImage = systemImage
        self.newBadge = newBadge
        self.isImageOverlay = isImageOverlay
        self.offset = offset
        self.frameworkImage = frameworkImage
        
        self._sideSize = State(initialValue: self.size == .small ? 22 : self.size == .medium ? 26 : self.size == .textSize ? 16 : 30)
    }
    
    public var body: some View {
        ZStack { 
            if !image.isEmpty {
                Image(image)
                    .resizable()
                    .frame(width: sideSize, height: sideSize)
                    .offset(calcOffset())
                    .if(isImageOverlay) { view in
                        view
                            .defaultShadow()
                    }
            }else if !frameworkImage.isEmpty {
                ImageProvider.image(frameworkImage)
                    .resizable()
                    .frame(width: sideSize, height: sideSize)
                    .offset(calcOffset())
                    .if(isImageOverlay) { view in
                        view
                            .defaultShadow()
                    }
            } else {
                Image(systemName: systemImage)
                    .font(.system(size: systemImage != "" ? sideSize - 4 : sideSize))
                    .offset(calcOffset())
                    .if(isImageOverlay) { view in
                        view
                            .defaultShadow()
                    }
            }
            
            if(newBadge != nil && newBadge!){
                CLNewBadge()
                    .offset(x: sideSize / 3, y: -sideSize / 3)
            }
        }
    }
    
    private func calcOffset() -> CGSize {
        switch offset {
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
