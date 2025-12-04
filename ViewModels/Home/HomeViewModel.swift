//
//  HomeViewModel.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation
import Combine
import UIKit

class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var userName: String = "Gäst"
    @Published var greeting: String = ""
    @Published var dailyQuote: (text: String, author: String) = ("", "")
    @Published var dailyActivities: [Activity] = []
    @Published var bonusActivity: Activity?
    @Published var completedActivities: Set<String> = []
    @Published var isLoading: Bool = false

    // MARK: - Private Properties
    private let storageManager: StorageManager
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    init(storageManager: StorageManager = .shared) {
        self.storageManager = storageManager
        setupInitialData()
    }

    // MARK: - Setup
    private func setupInitialData() {
        loadUserData()
        checkDailyReset()
        loadDailyActivities()
        loadBonusActivity()
        setGreeting()
        setDailyQuote()
    }

    // MARK: - Public Methods
    func loadUserData() {
        if let userData = storageManager.getUserData() {
            userName = userData.name.isEmpty ? "Gäst" : userData.name
        }
    }

    func refreshData() {
        checkDailyReset()
        loadDailyActivities()
        loadBonusActivity()
    }

    func completeActivity(_ activityId: String) {
        // Add haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        // Mark activity as completed
        storageManager.completeActivity(activityId)
        completedActivities.insert(activityId)

        // Update activity in list
        if let index = dailyActivities.firstIndex(where: { $0.id == activityId }) {
            dailyActivities[index].isCompleted = true
        }
    }

    func isActivityCompleted(_ activityId: String) -> Bool {
        completedActivities.contains(activityId)
    }

    // MARK: - Private Methods
    private func checkDailyReset() {
        if storageManager.shouldResetDailyActivities() {
            // New day - reset all activities
            completedActivities.removeAll()
            storageManager.updateLastActiveDate()
        } else {
            // Load today's completed activities
            let progress = storageManager.getDailyProgress()
            completedActivities = Set(progress.completedActivities)
        }
    }

    private func loadDailyActivities() {
        dailyActivities = Activity.dailyActivities

        // Update completion status
        for index in dailyActivities.indices {
            let activityId = dailyActivities[index].id
            dailyActivities[index].isCompleted = completedActivities.contains(activityId)
        }
    }

    private func loadBonusActivity() {
        let hour = Calendar.current.component(.hour, from: Date())

        // Before 3 PM: Show Dynamic Meditation
        // After 3 PM: Show Kundalini Meditation
        if hour < 15 {
            bonusActivity = Activity.dynamicMeditation
        } else {
            bonusActivity = Activity.kundaliniMeditation
        }
    }

    private func setGreeting() {
        let period = Constants.TimePeriod.current()
        greeting = "\(period.greeting), \(userName)"
    }

    private func setDailyQuote() {
        // Get quote based on current date (same quote per day)
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        let index = dayOfYear % Constants.quotes.count
        dailyQuote = Constants.quotes[index]
    }

    // MARK: - Computed Properties
    var completionProgress: Double {
        let total = dailyActivities.count
        guard total > 0 else { return 0 }
        let completed = dailyActivities.filter { $0.isCompleted }.count
        return Double(completed) / Double(total)
    }

    var allActivitiesCompleted: Bool {
        dailyActivities.allSatisfy { $0.isCompleted }
    }
}
