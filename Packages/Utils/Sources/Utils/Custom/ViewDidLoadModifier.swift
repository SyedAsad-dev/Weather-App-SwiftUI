//
//  ViewDidLoadModifier.swift
//  Utils
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import Foundation
import SwiftUI

public struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: () -> Void
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action()
                }
            }
    }
}

extension View {
    public func onViewDidLoad(perform action: @escaping () -> Void) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}
