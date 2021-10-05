//
//  UIDevice.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

public extension UIDevice {
    
    /// Returns true if the current device is an iPad, false if not
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// Returns true if the current device is an iPhone, false if not
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

