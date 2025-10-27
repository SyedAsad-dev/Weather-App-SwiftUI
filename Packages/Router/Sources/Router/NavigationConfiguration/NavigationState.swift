//
//  NavigationState.swift
//  Router
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import SwiftUI

@MainActor
public protocol NavigationStateProtocol {
    func goTo(_ route:Route)
    func goBack()
}

@MainActor
public final class AppNavHandlerViewModel: NavigationStateProtocol , ObservableObject {
    
    @Published public var appRoutes: [Route] = []
    

    public func goTo(_ route:Route) {
        Task {
            await MainActor.run {
                appRoutes.append(route)
            
            }
        }
    }
    
    public func goBack() {
        Task {
            await MainActor.run {
                _ = appRoutes.popLast()
            }
        }
    }
}
