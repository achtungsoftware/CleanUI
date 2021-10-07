//
//  Attribute.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI

public enum Attribute {
    case links(onTapAction: ((String) -> Void)? = nil)
    case hashtags(onTapAction: ((String) -> Void)? = nil)
    case mentions(onTapAction: ((String) -> Void)? = nil)
}
