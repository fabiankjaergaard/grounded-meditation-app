//
//  OnboardingViewModel.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation
import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var userName: String = ""
    @Published var profileImage: Data? = nil
    @Published var notificationsEnabled: Bool = false

    private let storageManager = StorageManager.shared
    private let notificationManager = NotificationManager.shared

    let totalSteps = 5

    func nextStep() {
        if currentStep < totalSteps - 1 {
            currentStep += 1
        }
    }

    func previousStep() {
        if currentStep > 0 {
            currentStep -= 1
        }
    }

    func completeOnboarding(completion: @escaping () -> Void) {
        // Save user data
        let userData = UserData(
            name: userName,
            profileImage: profileImage,
            notificationsEnabled: notificationsEnabled,
            onboardingCompleted: true,
            joinDate: Date()
        )
        storageManager.saveUserData(userData)

        // Setup notifications if enabled
        if notificationsEnabled {
            notificationManager.requestAuthorization { granted in
                if granted {
                    self.notificationManager.scheduleDailyReminders()
                }
            }
        }

        completion()
    }
}
