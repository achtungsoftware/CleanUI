//
//  CLAlert.swift
//  CleanUI
//
//  Created by Julian Gerhards on 11.10.21.
//

import SwiftUI

/// This is the main Alert wrapper
internal struct CLALert<Content: View>: View {
    
    var content: Content
    
    @State private var show: Bool = false
    
    var body: some View {
        ZStack {
            if(show){
                Color.black
                    .opacity(0.25)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .onTapGesture {
                        close()
                    }
                
                VStack(spacing: 0) {
                    content
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.alert)
                )
                .padding()
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.3)) {
                show = true
            }
        }
    }
    
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.25)) {
            show = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            CUAlert.clearAll()
        }
    }
}
