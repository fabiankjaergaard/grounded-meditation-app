//
//  Activity.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation

/// Represents a daily activity (meditation, breathwork, reflection, etc.)
struct Activity: Identifiable, Codable {
    var id: String
    var label: String // "MORGON", "UNDER DAGEN", "KVÄLL"
    var title: String
    var subtitle: String
    var duration: String // "5 min"
    var icon: String // SF Symbol name
    var type: ActivityType
    var isCompleted: Bool = false

    enum ActivityType: String, Codable {
        case breathwork
        case meditation
        case video
        case quote
    }
}

// MARK: - Sample Activities
extension Activity {
    static let morningBreath = Activity(
        id: "morning_breath",
        label: "MORGON",
        title: "Morgonandning",
        subtitle: "Aktivera kropp & sinne",
        duration: "5 min",
        icon: "heart.fill",
        type: .breathwork
    )

    static let middayReset = Activity(
        id: "midday_reset",
        label: "UNDER DAGEN",
        title: "Middag Reset",
        subtitle: "Meditation + dagens citat",
        duration: "5 min",
        icon: "play.circle.fill",
        type: .quote
    )

    static let eveningReflection = Activity(
        id: "evening_reflection",
        label: "KVÄLL",
        title: "Dagens Reflektion",
        subtitle: "Reflections of Life",
        duration: "10 min",
        icon: "video.fill",
        type: .video
    )

    static let dynamicMeditation = Activity(
        id: "dynamic_meditation",
        label: "BONUS",
        title: "Dynamic Meditation",
        subtitle: "Kraftfull morgonmeditation",
        duration: "60 min",
        icon: "bolt.fill",
        type: .meditation
    )

    static let kundaliniMeditation = Activity(
        id: "kundalini_meditation",
        label: "BONUS",
        title: "Kundalini Meditation",
        subtitle: "Skakningar och dans",
        duration: "60 min",
        icon: "sparkles",
        type: .meditation
    )

    /// Get all daily activities (morning, midday, evening)
    static var dailyActivities: [Activity] {
        [morningBreath, middayReset, eveningReflection]
    }
}
