//
//  CUAlertModel.swift
//  CleanUI
//
//  Created by Julian Gerhards on 10.10.21.
//

import SwiftUI


/// The ``CUAlertModel`` is used for ``CUSheet``, ``CUAlert``, ``CUInAppNotification`` and ``CUAlertMessage``
public struct CUAlertModel: Identifiable, Equatable {
    public var id = UUID()
    public var view: UIView
    public var shouldDismiss: Bool = false
}
