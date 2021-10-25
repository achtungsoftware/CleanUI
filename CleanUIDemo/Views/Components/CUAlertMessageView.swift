//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import SwiftUI
import CleanUI

struct CUAlertMessageView: View {
    var body: some View {
        List {
            Button(action: {
                CUAlertMessage.show("This is a normal CUAlertMessage with more text than usual", subTitle: "And we got a subTitle !!!")
            }){
                Text("Test CUAlertMessage .normal")
            }
            
            Button(action: {
                CUAlertMessage.show("This is a normal CUAlertMessage")
            }){
                Text("Test CUAlertMessage .normal")
            }
            
            Button(action: {
                CUAlertMessage.show("This is a error CUAlertMessage", type: .error)
            }){
                Text("Test CUAlertMessage .error")
            }
            
            Button(action: {
                CUAlertMessage.show("This is a success CUAlertMessage", type: .success)
            }){
                Text("Test CUAlertMessage .success")
            }
        }
        .navigationBar("CUAlertMessage")
    }
}
