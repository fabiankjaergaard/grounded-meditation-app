//
//  StorageManager.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation

/// Manages local data persistence using UserDefaults
class StorageManager {
    // MARK: - Singleton
    static let shared = StorageManager()

    // MARK: - Private Properties
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Keys
    private enum Keys {
        static let userData = "user_data"
        static let dailyProgress = "daily_progress"
        static let lastActiveDate = "last_active_date"
        static let completedActivitiesPrefix = "completed_activities_"
        static let reflections = "reflections"
    }

    // MARK: - Initialization
    private init() {
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }

    // MARK: - User Data
    func saveUserData(_ userData: UserData) {
        if let encoded = try? encoder.encode(userData) {
            defaults.set(encoded, forKey: Keys.userData)
        }
    }

    func getUserData() -> UserData? {
        guard let data = defaults.data(forKey: Keys.userData),
              let userData = try? decoder.decode(UserData.self, from: data) else {
            return nil
        }
        return userData
    }

    func hasCompletedOnboarding() -> Bool {
        getUserData()?.onboardingCompleted ?? false
    }

    func completeOnboarding() {
        var userData = getUserData() ?? UserData()
        userData.onboardingCompleted = true
        saveUserData(userData)
    }

    // MARK: - Daily Progress
    func getDailyProgress(for date: Date = Date()) -> DailyProgress {
        let dateString = date.dateString
        let key = Keys.completedActivitiesPrefix + dateString

        guard let data = defaults.data(forKey: key),
              let progress = try? decoder.decode(DailyProgress.self, from: data) else {
            return DailyProgress(date: dateString)
        }
        return progress
    }

    func saveDailyProgress(_ progress: DailyProgress) {
        let key = Keys.completedActivitiesPrefix + progress.date
        if let encoded = try? encoder.encode(progress) {
            defaults.set(encoded, forKey: key)
        }
    }

    func completeActivity(_ activityId: String, on date: Date = Date()) {
        var progress = getDailyProgress(for: date)
        progress.completeActivity(activityId)
        saveDailyProgress(progress)

        // Update user statistics
        updateStatistics(completedActivity: activityId)
    }

    func isActivityCompleted(_ activityId: String, on date: Date = Date()) -> Bool {
        getDailyProgress(for: date).isActivityCompleted(activityId)
    }

    // MARK: - Daily Reset
    func shouldResetDailyActivities() -> Bool {
        guard let lastActiveDate = getLastActiveDate() else {
            return true
        }
        return !Calendar.current.isDateInToday(lastActiveDate)
    }

    func updateLastActiveDate(_ date: Date = Date()) {
        defaults.set(date, forKey: Keys.lastActiveDate)
    }

    func getLastActiveDate() -> Date? {
        defaults.object(forKey: Keys.lastActiveDate) as? Date
    }

    // MARK: - Statistics
    private func updateStatistics(completedActivity: String) {
        guard var userData = getUserData() else { return }

        userData.totalSessions += 1

        // Add minutes based on activity type
        let activityDuration = getActivityDuration(completedActivity)
        userData.totalMinutes += activityDuration

        // Update streak
        updateStreak(for: &userData)

        saveUserData(userData)
    }

    private func getActivityDuration(_ activityId: String) -> Int {
        switch activityId {
        case "morning_breath", "midday_reset":
            return 5
        case "evening_reflection":
            return 10
        case "dynamic_meditation", "kundalini_meditation":
            return 60
        default:
            return 5
        }
    }

    private func updateStreak(for userData: inout UserData) {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        let todayProgress = getDailyProgress(for: today)
        let yesterdayProgress = getDailyProgress(for: yesterday)

        if !todayProgress.completedActivities.isEmpty {
            if yesterdayProgress.completedActivities.isEmpty {
                // First day or streak broken
                userData.currentStreak = 1
            } else {
                // Continue streak (already incremented)
            }
        }
    }

    // MARK: - Reflections
    func saveReflection(_ reflection: Reflection) {
        var reflections = getAllReflections()
        reflections.append(reflection)

        if let encoded = try? encoder.encode(reflections) {
            defaults.set(encoded, forKey: Keys.reflections)
        }
    }

    func getAllReflections() -> [Reflection] {
        guard let data = defaults.data(forKey: Keys.reflections),
              let reflections = try? decoder.decode([Reflection].self, from: data) else {
            return []
        }
        return reflections
    }

    func getReflection(for videoId: String, on date: Date = Date()) -> Reflection? {
        let reflections = getAllReflections()

        return reflections.first { reflection in
            reflection.videoId == videoId &&
            Calendar.current.isDate(reflection.date, inSameDayAs: date)
        }
    }

    func deleteReflection(_ reflection: Reflection) {
        var reflections = getAllReflections()
        reflections.removeAll { $0.id == reflection.id }

        if let encoded = try? encoder.encode(reflections) {
            defaults.set(encoded, forKey: Keys.reflections)
        }
    }

    // MARK: - Reset Daily Activities (for testing)
    func resetTodaysActivities() {
        let dateString = Date().dateString
        let key = Keys.completedActivitiesPrefix + dateString
        defaults.removeObject(forKey: key)
        updateLastActiveDate(Date().addingTimeInterval(-86400)) // Set to yesterday to force refresh
    }

    // MARK: - Clear All Data (for testing/logout)
    func clearAllData() {
        defaults.removeObject(forKey: Keys.userData)
        defaults.removeObject(forKey: Keys.dailyProgress)
        defaults.removeObject(forKey: Keys.lastActiveDate)
        defaults.removeObject(forKey: Keys.reflections)

        // Clear all daily progress entries
        let allKeys = defaults.dictionaryRepresentation().keys
        allKeys.filter { $0.hasPrefix(Keys.completedActivitiesPrefix) }
            .forEach { defaults.removeObject(forKey: $0) }
    }
}
