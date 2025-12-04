//
//  DailyQuoteScreen.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct DailyQuoteScreen: View {
    @Environment(\.dismiss) var dismiss
    let onComplete: () -> Void

    @State private var currentQuoteIndex = 0
    @State private var meditationTime: TimeInterval = 300 // 5 minutes
    @State private var isTimerRunning = false
    @State private var timeRemaining: TimeInterval = 300

    let quotes = Constants.quotes

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient.welcomeGradient
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Top bar
                    topBar

                    Spacer()

                    // Quote card
                    quoteCard

                    Spacer()

                    // Timer section
                    timerSection

                    // Bottom button
                    bottomButton
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                setRandomQuote()
            }
        }
    }

    // MARK: - Top Bar
    private var topBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
            }

            Spacer()

            Text("Middag Reset")
                .font(Constants.Typography.bodyBold)
                .foregroundColor(.white)

            Spacer()

            // Invisible spacer to balance layout
            Color.clear.frame(width: 44, height: 44)
        }
        .padding(Constants.Spacing.standard)
    }

    // MARK: - Quote Card
    private var quoteCard: some View {
        VStack(spacing: Constants.Spacing.standard) {
            Image(systemName: "quote.opening")
                .font(.system(size: 48))
                .foregroundColor(.white.opacity(0.5))

            Text(quotes[currentQuoteIndex].text)
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(.white)
                .italic()
                .multilineTextAlignment(.center)
                .lineSpacing(8)

            Text("— \(quotes[currentQuoteIndex].author)")
                .font(Constants.Typography.body)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(Constants.Spacing.xl)
        .background(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                .fill(Color.white.opacity(0.1))
        )
        .padding(Constants.Spacing.standard)
    }

    // MARK: - Timer Section
    private var timerSection: some View {
        VStack(spacing: 16) {
            Text("Meditation (valfritt)")
                .font(Constants.Typography.subheadline)
                .foregroundColor(.white.opacity(0.9))

            if isTimerRunning {
                // Timer countdown
                Text(timeString(from: timeRemaining))
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                    .monospacedDigit()

                Button(action: stopTimer) {
                    Text("Stopp")
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(Constants.CornerRadius.button)
                }
            } else {
                Button(action: startTimer) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                        Text("Starta 5 min meditation")
                    }
                    .font(Constants.Typography.bodyBold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(Constants.CornerRadius.button)
                }
            }
        }
        .padding(.bottom, Constants.Spacing.standard)
    }

    // MARK: - Bottom Button
    private var bottomButton: some View {
        Button(action: {
            onComplete()
            dismiss()
        }) {
            Text("Färdig")
                .font(Constants.Typography.bodyBold)
                .foregroundColor(Constants.Colors.primaryBlue)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.white)
                .cornerRadius(Constants.CornerRadius.button)
        }
        .padding(Constants.Spacing.standard)
    }

    // MARK: - Helper Methods
    private func setRandomQuote() {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        currentQuoteIndex = dayOfYear % quotes.count
    }

    private func startTimer() {
        isTimerRunning = true
        timeRemaining = meditationTime

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                isTimerRunning = false
                // Haptic feedback
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
        }
    }

    private func stopTimer() {
        isTimerRunning = false
        timeRemaining = meditationTime
    }

    private func timeString(from seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, secs)
    }
}

#Preview {
    DailyQuoteScreen {
        print("Completed!")
    }
}
