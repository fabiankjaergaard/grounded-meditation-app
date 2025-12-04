//
//  DateExtensions.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation

extension Date {
    /// Format date as "2025-12-03"
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }

    /// Format date as "3 December 2025"
    var longDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "sv_SE")
        return formatter.string(from: self)
    }

    /// Format date as "3 dec"
    var shortDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "sv_SE")
        return formatter.string(from: self)
    }

    /// Format time as "14:30"
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }

    /// Check if date is today
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// Check if date is yesterday
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    /// Get relative date string (e.g., "Idag", "Igår", "3 dec")
    var relativeDateString: String {
        if isToday {
            return "Idag"
        } else if isYesterday {
            return "Igår"
        } else {
            return shortDateString
        }
    }

    /// Get days between this date and another date
    func daysBetween(_ otherDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: otherDate)
        return abs(components.day ?? 0)
    }

    /// Add days to date
    func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }

    /// Start of day (00:00:00)
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// End of day (23:59:59)
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }
}

extension Calendar {
    /// Check if two dates are on the same day
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        return isDate(date1, inSameDayAs: date2)
    }
}
