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
import CleanUI

struct AlertsPage: View {
    var body: some View {
        List {
            Button(action: {
                CUAlert.show(Text("Hallo CUAlert!").padding())
            }) {
                Text("CUAlert")
            }
            
            Button(action: {
                CUSheet.show(Text("Hallo CUSheet!").padding())
            }) {
                Text("CUSheet")
            }
            
            Button(action: {
                CUAlertMessage.show("Hallo CUAlertMessage!", subTitle: "Subtitle")
            }) {
                Text("CUAlertMessage")
            }
            
            Button(action: {
                CUInAppNotification.show(title: "Hallo CUInAppNotification!", body: "Body")
            }) {
                Text("CUInAppNotification")
            }
        }
        .navigationTitle("Alerts")
        .navigationBarTitleDisplayMode(.inline)
    }
}
