//
//  NotificationManager.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation
import UserNotifications

/// Manages local notifications for daily reminders
class NotificationManager {
    // MARK: - Singleton
    static let shared = NotificationManager()

    // MARK: - Private Properties
    private let notificationCenter = UNUserNotificationCenter.current()

    // MARK: - Notification Identifiers
    private enum NotificationIds {
        static let morning = "morning_reminder"
        static let midday = "midday_reminder"
        static let evening = "evening_reminder"
    }

    // MARK: - Initialization
    private init() {}

    // MARK: - Authorization
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Notification authorization error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func checkAuthorizationStatus(completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }

    // MARK: - Schedule Notifications
    func scheduleDailyReminders() {
        // Morning reminder at 7:00 AM
        scheduleNotification(
            identifier: NotificationIds.morning,
            title: "God morgon! ☀️",
            body: "Börja dagen med morgonandning",
            hour: 7,
            minute: 0
        )

        // Midday reminder at 12:00 PM
        scheduleNotification(
            identifier: NotificationIds.midday,
            title: "Dags för en paus? 🧘",
            body: "Ta en kort meditation",
            hour: 12,
            minute: 0
        )

        // Evening reminder at 7:00 PM
        scheduleNotification(
            identifier: NotificationIds.evening,
            title: "Dagens reflektion 🌙",
            body: "Se dagens reflektion och summera din dag",
            hour: 19,
            minute: 0
        )
    }

    private func scheduleNotification(
        identifier: String,
        title: String,
        body: String,
        hour: Int,
        minute: Int
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        notificationCenter.add(request) { error in
            if let error = error {
                print("❌ Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("✅ Scheduled notification: \(identifier)")
            }
        }
    }

    // MARK: - Cancel Notifications
    func cancelAllNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("🔕 All notifications cancelled")
    }

    func cancelNotification(withIdentifier identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        print("🔕 Cancelled notification: \(identifier)")
    }

    // MARK: - Get Pending Notifications
    func getPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> Void) {
        notificationCenter.getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                completion(requests)
            }
        }
    }
}
