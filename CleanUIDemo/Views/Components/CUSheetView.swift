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

struct CUSheetView: View {
    var body: some View {
        List {
            Button(action: {
                CUSheet.show(
                    CLSheetConfirmView("This is a slightly longer title just for testing", subTitle: "This is a subtitle This is a subtitle This is a subtitle This is a subtitle This is a subtitle ", confirmAction: {
                        CUAlertMessage.show("CLSheetConfirmView button tapped")
                    })
                )
            }){
                Text("Test CUSheet with CLSheetConfirmView")
            }
            
            Button(action: {
                CUSheet.show(
                    VStack {
                        Text("This is a CUSheet")
                            .font(.title)
                        
                        Text("And inside is a Button")
                            .font(.subheadline)
                        
                        Button(action: {
                            CUAlertMessage.show("Button tapped")
                        }){
                            Text("Button")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                        .padding()
                )
            }){
                Text("Test CUSheet with Text and Button inside")
            }
            
            Button(action: {
                CUSheet.show(
                    List {
                        Text("List item")
                        Text("List item")
                        Text("List item")
                        Text("List item")
                        Text("List item")
                    }
                )
            }){
                Text("Test CUSheet with a List inside")
            }
            
            Button(action: {
                CUSheet.show(
                    CLScrollView {
                        VStack {
                            Text("VStack item")
                            Text("VStack item")
                            Text("VStack item")
                            Text("VStack item")
                            Text("VStack item")
                        }
                    }
                )
            }){
                Text("Test CUSheet with a CLScrollView inside")
            }
            
            Button(action: {
                CUSheet.show(
                    VStack {
                        CLSheetTitle("This is a CUSheetTitle")
                        CLSheetMenu([
                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                CUAlertMessage.show("CUSheetMenuItem tapped")
                            }, icon: CLIcon(systemImage: "square.and.arrow.up.fill", size: .small, newBadge: true)),
                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                CUAlertMessage.show("CUSheetMenuItem tapped")
                            }),
                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                CUAlertMessage.show("CUSheetMenuItem tapped")
                            }),
                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                CUAlertMessage.show("CUSheetMenuItem tapped")
                            }),
                            CLSheetMenuItem(title: "This is a CUSheetMenuItem", show: true, action: {
                                CUAlertMessage.show("CUSheetMenuItem tapped")
                            })
                        ])
                    }
                )
            }){
                Text("Test CUSheet with a CUSheetMenu inside")
            }
        }
        .navigationBar("CUSheet")
    }
}
