//
//  Extension+Int.swift
//  Utils
//
//  Created by Rizvi Naqvi on 20/10/2025.
//

import Foundation

// Helper extension to convert Int timestamp (seconds) to Date and get day component
extension Int {
   public func toDate() -> Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }
}
