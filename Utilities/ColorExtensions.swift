//
//  ColorExtensions.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

extension Color {
    /// Initialize Color from hex string
    /// - Parameter hex: Hex string (e.g., "#2B4C7E" or "2B4C7E")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    /// Create a gradient background
    static func gradient(
        colors: [Color],
        startPoint: UnitPoint = .topLeading,
        endPoint: UnitPoint = .bottomTrailing
    ) -> LinearGradient {
        LinearGradient(
            colors: colors,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }
}

// MARK: - Predefined Gradients
extension LinearGradient {
    /// Welcome/Completion screen gradient
    static let welcomeGradient = LinearGradient(
        colors: [
            Color(hex: "#1a365d"),
            Color(hex: "#2B4C7E"),
            Color(hex: "#3D5A80")
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    /// Inhale phase gradient (blue shades)
    static let inhaleGradient = LinearGradient(
        colors: [
            Color(hex: "#4A90E2"),
            Color(hex: "#2B4C7E")
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    /// Exhale phase gradient (purple/orange shades)
    static let exhaleGradient = LinearGradient(
        colors: [
            Color(hex: "#8E54E9"),
            Color(hex: "#FF6B6B")
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    /// Hold phase gradient (neutral)
    static let holdGradient = LinearGradient(
        colors: [
            Color(hex: "#7F8C8D"),
            Color(hex: "#95A5A6")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}
