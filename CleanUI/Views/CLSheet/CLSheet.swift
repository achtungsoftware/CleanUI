//
//  CLSheet.swift
//  CleanUI
//
//  Created by Julian Gerhards on 11.10.21.
//

import SwiftUI

/// This is the main Sheet wrapper
internal struct CLSheet<Content: View>: View {
    
    var content: Content
    
    @State private var show: Bool = false
    @State private var showBackground: Bool = false
    @State private var offset = CGSize.zero
    @State var height: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if(showBackground){
                    Color.black
                        .opacity(0.25)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                }
                
                VStack(spacing: 0) {
                    Color.black
                        .opacity(0.001)
                        .onTapGesture {
                            close()
                        }
                    
                    if(show){
                        VStack(spacing: 0) {
                            HStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(.secondary)
                                    .frame(width: 40, height: 5, alignment: .center)
                            }
                            .padding(10)
                            content
                            
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width, height: (geometry.safeAreaInsets.bottom + 50) + abs(offset.height) / 4)
                        }
                        .transition(.move(edge: .bottom))
                        .frame(width: UIScreen.main.bounds.width)
                        .background(Color.alert)
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .offset(x: 0, y: offset.height > 0 ? offset.height + 50 : 50)
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .ignoresSafeArea(edges: .bottom)
            .highPriorityGesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { g in
                        if (offset.height > 0 && abs(offset.height) > 60) {
                            close()
                        } else {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                offset = .zero
                            }
                        }
                    }
            )
            .onAppear {
                height = geometry.size.height
                withAnimation(Animation.interpolatingSpring(mass: 0.2, stiffness: 29.5, damping: 12, initialVelocity: 10)){
                    show = true
                    showBackground = true
                }
            }
        }
    }
    
    func close() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            offset.height = height
            showBackground = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            CUSheet.clearAll()
        }
    }
}
