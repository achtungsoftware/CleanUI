//
//  GeometryProxy.swift
//  CleanUI
//
//  Created by Julian Gerhards on 07.10.21.
//

import SwiftUI

public extension GeometryProxy {
    var maxWidth: CGFloat {
        size.width - safeAreaInsets.leading - safeAreaInsets.trailing
    }
}
