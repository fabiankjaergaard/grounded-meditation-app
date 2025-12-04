//
//  UserData.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation

/// User profile and settings data
struct UserData: Codable {
    var name: String
    var profileImage: Data?
    var notificationsEnabled: Bool
    var onboardingCompleted: Bool
    var retreatDate: Date?
    var group: String?
    var joinDate: Date

    // Statistics
    var totalSessions: Int
    var currentStreak: Int
    var totalMinutes: Int

    init(
        name: String = "",
        profileImage: Data? = nil,
        notificationsEnabled: Bool = false,
        onboardingCompleted: Bool = false,
        retreatDate: Date? = nil,
        group: String? = nil,
        joinDate: Date = Date(),
        totalSessions: Int = 0,
        currentStreak: Int = 0,
        totalMinutes: Int = 0
    ) {
        self.name = name
        self.profileImage = profileImage
        self.notificationsEnabled = notificationsEnabled
        self.onboardingCompleted = onboardingCompleted
        self.retreatDate = retreatDate
        self.group = group
        self.joinDate = joinDate
        self.totalSessions = totalSessions
        self.currentStreak = currentStreak
        self.totalMinutes = totalMinutes
    }
}
