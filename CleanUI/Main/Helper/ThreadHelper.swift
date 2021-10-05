//
//  ThreadHelper.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

/// A class for handling DispatchQueues. Only sugar but makes it easy to remember
public class ThreadHelper {
    
    public enum async {
    case userInteractive
    case userInitiated
    case utility
    case background
    case main
        
        
        /// Runs the defined callback
        /// - Parameter callback: The callback
        public func run(_ callback: @escaping () -> Void) {
            switch self {
            case .userInitiated:
                DispatchQueue.global(qos: .userInitiated).async {
                    callback()
                }
            case .utility:
                DispatchQueue.global(qos: .utility).async {
                    callback()
                }
            case .background:
                DispatchQueue.global(qos: .background).async {
                    callback()
                }
            case .main:
                DispatchQueue.main.async {
                    callback()
                }
            case .userInteractive:
                DispatchQueue.global(qos: .userInteractive).async {
                    callback()
                }
            }
        }
    }
}

