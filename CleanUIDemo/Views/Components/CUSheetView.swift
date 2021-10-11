//
//  CUSheetView.swift
//  CleanUIDemo
//
//  Created by Julian Gerhards on 11.10.21.
//

import SwiftUI
import CleanUI

struct CUSheetView: View {
    var body: some View {
        List {
            Button(action: {
                CUSheet.show(
                    CLSheetConfirmView("Test", subTitle: "This is a subtitle", confirmAction: {
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
