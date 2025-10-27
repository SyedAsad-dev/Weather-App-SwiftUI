//
//  Extension+Date.swift
//  Utils
//
//  Created by Rizvi Naqvi on 20/10/2025.
//
import Foundation

extension Date {
    private static let dayStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    private static let dayWordFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    public func dayString() -> String {
        return Date.dayStringFormatter.string(from: self)
    }
   public func dayWord() -> String {
        return Date.dayWordFormatter.string(from: self)
    }
    public func isSameDay(as otherDate: Date) -> Bool {
         Calendar.current.isDate(self, inSameDayAs: otherDate)
     }
}
