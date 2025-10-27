//
//  ToastModifier.swift
//  Utils
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import SwiftUI

// Custom ViewModifier for the toast
public struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let duration: TimeInterval = 2.0 // Duration for the toast to be visible

   public func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Spacer() // Push toast to the bottom
                    Text(message)
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .transition(.opacity) // Add a fade transition
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation(.easeInOut) {
                                    isPresented = false
                                }
                            }
                        }
                } .animation(.easeInOut, value: isPresented)
                .padding(.bottom, 10) // Adjust vertical position
            }
        }
    }
}

// Extension to make the toast modifier easily applicable
extension View {
   public func toast(isPresented: Binding<Bool>, message: String) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message))
    }
}
