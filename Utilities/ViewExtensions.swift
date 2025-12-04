//
//  ViewExtensions.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

// MARK: - Card Style
extension View {
    /// Apply card styling with shadow and optional border
    func cardStyle(isActive: Bool = false) -> some View {
        self.modifier(CardModifier(isActive: isActive))
    }
}

struct CardModifier: ViewModifier {
    var isActive: Bool

    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(Constants.CornerRadius.card)
            .shadow(
                color: Constants.Shadow.color,
                radius: Constants.Shadow.radius,
                x: Constants.Shadow.x,
                y: Constants.Shadow.y
            )
            .overlay(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                    .stroke(
                        isActive ? Constants.Colors.primaryBlue : Color.clear,
                        lineWidth: 2
                    )
            )
    }
}

// MARK: - Placeholder Modifier
extension View {
    /// Show placeholder text when condition is true
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// MARK: - Conditional Modifier
extension View {
    /// Apply a modifier conditionally
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Hide Keyboard
extension View {
    /// Hide keyboard when tapping outside
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

// MARK: - Safe Area Insets
extension View {
    /// Get safe area insets
    func getSafeAreaInsets() -> UIEdgeInsets {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return .zero
        }
        return window.safeAreaInsets
    }
}

// MARK: - Haptic Feedback
extension View {
    /// Trigger haptic feedback
    func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Loading Overlay
extension View {
    /// Show loading overlay
    func loading(_ isLoading: Bool) -> some View {
        self.overlay {
            if isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.5)
                }
            }
        }
    }
}
