//
//  DailyProgress.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation

/// Tracks which activities have been completed for a specific date
struct DailyProgress: Codable {
    var date: String // Format: "2025-12-03"
    var completedActivities: [String] // Activity IDs

    init(date: String = Date().dateString, completedActivities: [String] = []) {
        self.date = date
        self.completedActivities = completedActivities
    }

    /// Check if a specific activity is completed today
    func isActivityCompleted(_ activityId: String) -> Bool {
        completedActivities.contains(activityId)
    }

    /// Add an activity to completed list
    mutating func completeActivity(_ activityId: String) {
        if !completedActivities.contains(activityId) {
            completedActivities.append(activityId)
        }
    }
}
