//
//  Meditation.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation

/// Represents a meditation type available in the app
struct Meditation: Identifiable, Codable {
    var id: String
    var title: String
    var duration: String
    var category: MeditationCategory
    var description: String
    var isAvailable: Bool

    enum MeditationCategory: String, Codable, CaseIterable {
        case alla = "Alla"
        case aktiv = "Aktiv"
        case breathwork = "Breathwork"
        case dans = "Dans"
        case stillhet = "Stillhet"
    }
}

// MARK: - Sample Meditations
extension Meditation {
    static let dynamicMeditation = Meditation(
        id: "dynamic",
        title: "Dynamic Meditation",
        duration: "60 minuter",
        category: .aktiv,
        description: "En kraftfull morgonmeditation i fem faser: andning, catharsis, mantra, stillhet och celebration.",
        isAvailable: true
    )

    static let kundaliniMeditation = Meditation(
        id: "kundalini",
        title: "Kundalini Meditation",
        duration: "60 minuter",
        category: .aktiv,
        description: "Skakningar, dans och stillhet. Perfekt för att släppa spänningar i kroppen.",
        isAvailable: true
    )

    static let boxBreathing = Meditation(
        id: "box_breathing",
        title: "Box Breathing",
        duration: "5-20 minuter",
        category: .breathwork,
        description: "4-4-4-4 andning för lugn och fokus. Perfekt för stresshantering.",
        isAvailable: true
    )

    static let nadabrahma = Meditation(
        id: "nadabrahma",
        title: "Nadabrahma",
        duration: "60 minuter",
        category: .stillhet,
        description: "Humming meditation för djup avslappning och inre frid.",
        isAvailable: false
    )

    static let chakraBreathing = Meditation(
        id: "chakra_breathing",
        title: "Chakra Breathing",
        duration: "60 minuter",
        category: .breathwork,
        description: "Balansera dina chakras genom målinriktad andning.",
        isAvailable: false
    )

    static let whirlingMeditation = Meditation(
        id: "whirling",
        title: "Whirling Meditation",
        duration: "60 minuter",
        category: .dans,
        description: "Sufi-inspirerad virvlande meditation.",
        isAvailable: false
    )

    /// All available meditations
    static var allMeditations: [Meditation] {
        [
            dynamicMeditation,
            kundaliniMeditation,
            boxBreathing,
            nadabrahma,
            chakraBreathing,
            whirlingMeditation
        ]
    }
}
