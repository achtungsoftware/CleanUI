//
//  CUInAppNotificationView.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 11.10.21.
//

import SwiftUI
import CleanUI

struct CUInAppNotificationView: View {
    var body: some View {
        List {
            Button(action: {
                CUInAppNotification.show(title: "I'm a CUInAppNotification title", body: "This is my body", tapAction: {
                    CUAlertMessage.show("CUInAppNotification action tapped")
                })
            }){
                Text("Test CUInAppNotification")
            }
        }
        .navigationBar("CUInAppNotification")
    }
}
