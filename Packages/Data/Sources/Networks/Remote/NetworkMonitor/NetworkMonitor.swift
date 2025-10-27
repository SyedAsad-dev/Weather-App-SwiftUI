//
//  NetworkMonitor.swift
//  Data
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import Network
import Foundation

@MainActor
public final class NetworkMonitor: ObservableObject, @unchecked Sendable {
    public static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    @Published private(set) var isConnected: Bool = false
    private var initialized = false
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isConnected = (path.status == .satisfied)
                self?.initialized = true
            }
        }
        monitor.start(queue: queue)
    }
    /// Returns the latest known status — waits until monitor has emitted at least one path
    public func currentStatus() async -> Bool {
        // Wait until first path update if not yet initialized
        while !initialized {
            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1s
        }
        return isConnected
    }
    /// Async stream for continuous network updates
    public var statusStream: AsyncStream<Bool> {
        AsyncStream { continuation in
            continuation.yield(isConnected)
            let task = Task {
                for await _ in $isConnected.values {
                    continuation.yield(isConnected)
                }
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }
}
