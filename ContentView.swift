//
//  ContentView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        Group {
            if appState.hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingContainerView {
                    appState.completeOnboarding()
                }
            }
        }
        .environmentObject(appState)
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var hasCompletedOnboarding: Bool = false

    init() {
        // TESTING: Uncomment to reset app and see onboarding again
        // StorageManager.shared.clearAllData()

        // Ensure user data exists before checking onboarding status
        if StorageManager.shared.getUserData() == nil {
            // First launch - create default user data
            let userData = UserData(
                name: "",
                onboardingCompleted: false,
                joinDate: Date()
            )
            StorageManager.shared.saveUserData(userData)
        }

        self.hasCompletedOnboarding = StorageManager.shared.hasCompletedOnboarding()
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
        StorageManager.shared.completeOnboarding()
    }
}

#Preview {
    // Preview with mock data
    let _ = {
        let userData = UserData(
            name: "Preview User",
            onboardingCompleted: true,
            joinDate: Date()
        )
        StorageManager.shared.saveUserData(userData)
    }()

    return ContentView()
}
