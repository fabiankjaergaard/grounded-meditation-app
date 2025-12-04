//
//  Constants.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation
import SwiftUI

/// App-wide constants for colors, spacing, typography, and configuration
enum Constants {
    // MARK: - Colors
    enum Colors {
        static let primaryBlue = Color(hex: "#2B4C7E")
        static let backgroundBeige = Color(hex: "#F5F5F0")
        static let textPrimary = Color(hex: "#2C3E50")
        static let textSecondary = Color(hex: "#7F8C8D")
        static let textTertiary = Color(hex: "#95A5A6")
        static let accentYellow = Color(hex: "#FFD93D")
        static let errorRed = Color(hex: "#FF6B6B")
        static let successGreen = Color(hex: "#2B4C7E") // Same as primary
        static let borderLight = Color(hex: "#E8F0F8")
        static let borderDefault = Color(hex: "#E0E0E0")
        static let cardBackground = Color(hex: "#FAFAF8")
    }

    // MARK: - Spacing
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let standard: CGFloat = 24
        static let lg: CGFloat = 32
        static let xl: CGFloat = 48
        static let xxl: CGFloat = 60
    }

    // MARK: - Corner Radius
    enum CornerRadius {
        static let card: CGFloat = 16
        static let button: CGFloat = 12
        static let input: CGFloat = 12
        static let small: CGFloat = 8
    }

    // MARK: - Typography (using system font)
    enum Typography {
        static let largeTitle = Font.system(size: 34, weight: .bold)
        static let title = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 24, weight: .bold)
        static let body = Font.system(size: 16, weight: .regular)
        static let bodyBold = Font.system(size: 16, weight: .semibold)
        static let subheadline = Font.system(size: 15, weight: .regular)
        static let caption = Font.system(size: 13, weight: .regular)
        static let label = Font.system(size: 11, weight: .bold)
    }

    // MARK: - Animation
    enum Animation {
        static let fast: Double = 0.2
        static let standard: Double = 0.3
        static let slow: Double = 0.5
    }

    // MARK: - Shadow
    enum Shadow {
        static let color = Color.black.opacity(0.08)
        static let radius: CGFloat = 10
        static let x: CGFloat = 0
        static let y: CGFloat = 3
    }

    // MARK: - Icons (SF Symbols)
    enum Icons {
        static let home = "house.fill"
        static let community = "person.3.fill"
        static let meditations = "circle.circle.fill"
        static let map = "map.fill"
        static let profile = "person.fill"
        static let heart = "heart.fill"
        static let play = "play.circle.fill"
        static let video = "video.fill"
        static let check = "checkmark.circle.fill"
        static let lock = "lock.fill"
        static let bell = "bell.fill"
        static let clock = "clock.fill"
        static let camera = "camera.fill"
        static let chevronRight = "chevron.right"
        static let chevronDown = "chevron.down"
        static let sparkles = "sparkles"
    }

    // MARK: - Quotes
    static let quotes: [(text: String, author: String)] = [
        ("Be present. Be grateful. Be yourself.", "Baravara"),
        ("Breath is the bridge between body and soul", "Thich Nhat Hanh"),
        ("Meditation is witnessing your own mind", "Osho"),
        ("In stillness we find our answers", "Baravara"),
        ("Accept what is, let go of what was", "Buddha")
    ]

    // MARK: - YouTube Video IDs
    enum VideoIDs {
        static let dailyReflection = "oGDLVkYKgAo" // Reflections of Life

        // Breathwork videos (5, 10, 15, 20 min)
        static let morningBreath5min = "5min_video_id"
        static let morningBreath10min = "10min_video_id"
        static let morningBreath15min = "15min_video_id"
        static let morningBreath20min = "20min_video_id"
    }

    // MARK: - Breathwork Patterns
    struct BreathPattern {
        let name: String
        let description: String
        let phases: [BreathPhase]

        struct BreathPhase {
            let type: PhaseType
            let duration: TimeInterval
            let text: String

            enum PhaseType {
                case inhale
                case hold
                case exhale
            }
        }
    }

    static let breathPatterns: [String: BreathPattern] = [
        "morning": BreathPattern(
            name: "Morning Breath",
            description: "Energizing breathing to wake the body",
            phases: [
                .init(type: .inhale, duration: 4, text: "Breathe in deeply"),
                .init(type: .hold, duration: 2, text: "Hold your breath"),
                .init(type: .exhale, duration: 6, text: "Breathe out slowly")
            ]
        ),
        "box": BreathPattern(
            name: "Box Breathing",
            description: "4-4-4-4 breathing for calm and focus",
            phases: [
                .init(type: .inhale, duration: 4, text: "Breathe in"),
                .init(type: .hold, duration: 4, text: "Hold"),
                .init(type: .exhale, duration: 4, text: "Breathe out"),
                .init(type: .hold, duration: 4, text: "Hold")
            ]
        ),
        "calm": BreathPattern(
            name: "4-7-8 Breathing",
            description: "Dr. Weil's technique for relaxation and sleep",
            phases: [
                .init(type: .inhale, duration: 4, text: "Breathe in"),
                .init(type: .hold, duration: 7, text: "Hold"),
                .init(type: .exhale, duration: 8, text: "Breathe out")
            ]
        )
    ]

    // MARK: - Time Periods
    enum TimePeriod {
        case morning
        case afternoon
        case evening
        case night

        static func current() -> TimePeriod {
            let hour = Calendar.current.component(.hour, from: Date())
            switch hour {
            case 0..<12:
                return .morning
            case 12..<18:
                return .afternoon
            case 18..<22:
                return .evening
            default:
                return .night
            }
        }

        var greeting: String {
            switch self {
            case .morning:
                return Strings.Home.morningGreeting
            case .afternoon:
                return Strings.Home.afternoonGreeting
            case .evening:
                return Strings.Home.eveningGreeting
            case .night:
                return Strings.Home.eveningGreeting // Use evening for night too
            }
        }
    }
}
