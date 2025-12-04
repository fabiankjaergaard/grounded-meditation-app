//
//  Strings.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-04.
//

import Foundation

struct Strings {
    // MARK: - Home Screen
    struct Home {
        static let dailyJourneyTitle = "Today's Journey"
        static let dailyJourneySubtitle = "Three simple practices to maintain your Baravara feeling throughout the day"
        static let bonusTitle = "Have more time?"

        // Greeting periods
        static let morningGreeting = "Good morning"
        static let afternoonGreeting = "Good afternoon"
        static let eveningGreeting = "Good evening"
    }

    // MARK: - Activity Selection
    struct ActivitySelection {
        static let title = "Choose your practice"
        static let subtitle = "How do you want to start your day?"

        // Meditation
        static let meditationTitle = "Start your day grounded"
        static let meditationDescription = "Meditation for inner peace"

        // Breathwork
        static let breathworkTitle = "Wake up with energy"
        static let breathworkDescription = "Breathwork for focus"
    }

    // MARK: - Duration Selection
    struct DurationSelection {
        static let title = "Choose duration"
        static func subtitle(activityType: String) -> String {
            activityType == "meditation"
                ? "How long do you want to meditate?"
                : "How long do you want to breathe?"
        }
        static let minutes = "minutes"
    }

    // MARK: - Mode Selection
    struct ModeSelection {
        static let title = "Choose type"
        static let subtitle = "How do you want to start your day?"

        static let videoTitle = "Guided Video"
        static let videoDescription = "Follow along in a video-guided session"

        static let interactiveTitle = "Interactive"
        static let interactiveDescription = "Breathe with animated guide"
    }

    // MARK: - Daily Activities
    struct Activities {
        static let morningLabel = "MORNING"
        static let morningTitle = "Morning Breathing"
        static let morningSubtitle = "Activate body & mind"

        static let middayLabel = "MIDDAY"
        static let middayTitle = "Midday Reset"
        static let middaySubtitle = "Meditation + daily quote"

        static let eveningLabel = "EVENING"
        static let eveningTitle = "Daily Reflection"
        static let eveningSubtitle = "Reflections of Life"

        // Bonus activities
        static let dynamicMeditationTitle = "Dynamic Meditation"
        static let dynamicMeditationSubtitle = "Powerful morning meditation"

        static let kundaliniMeditationTitle = "Kundalini Meditation"
        static let kundaliniMeditationSubtitle = "Evening energy practice"
    }

    // MARK: - Common
    struct Common {
        static let close = "Close"
        static let back = "Back"
        static let done = "Done"
        static let cancel = "Cancel"
    }
}
