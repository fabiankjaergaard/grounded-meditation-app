//
//  ActivityTypeSelectionView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-04.
//

import SwiftUI

struct ActivityTypeSelectionView: View {
    @Environment(\.dismiss) var dismiss
    let onComplete: (ActivityType, Int) -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Spacing.standard) {
                // Title
                VStack(spacing: 8) {
                    Text(Strings.ActivitySelection.title)
                        .font(Constants.Typography.title)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text(Strings.ActivitySelection.subtitle)
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textSecondary)
                }
                .padding(.top, 8)

                Spacer()
                    .frame(height: 16)

                // Activity type options
                VStack(spacing: 16) {
                    NavigationLink(destination: DurationSelectionView(activityType: .meditation, onSelectDuration: { duration in
                        onComplete(.meditation, duration)
                        dismiss()
                    }, backgroundImage: "meditationcard")) {
                        ActivityTypeCard(
                            title: Strings.ActivitySelection.meditationTitle,
                            description: Strings.ActivitySelection.meditationDescription,
                            backgroundImage: "meditationcard"
                        )
                    }
                    .buttonStyle(PlainButtonStyle())

                    NavigationLink(destination: DurationSelectionView(activityType: .breathwork, onSelectDuration: { duration in
                        onComplete(.breathwork, duration)
                        dismiss()
                    }, backgroundImage: "Breathworkbird")) {
                        ActivityTypeCard(
                            title: Strings.ActivitySelection.breathworkTitle,
                            description: Strings.ActivitySelection.breathworkDescription,
                            backgroundImage: "Breathworkbird"
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                Spacer()
                    .frame(minHeight: 20)
            }
            .padding(Constants.Spacing.standard)
            .background(Constants.Colors.backgroundBeige)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Constants.Colors.textPrimary)
                    }
                }
            }
        }
    }
}

// MARK: - Activity Type Card
struct ActivityTypeCard: View {
    let title: String
    let description: String
    let backgroundImage: String?

    var body: some View {
        VStack(spacing: 0) {
            // Background image or empty section
            ZStack {
                if let backgroundImage = backgroundImage {
                    Image(backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 160)
                        .offset(y: backgroundImage == "meditationcard" ? 30 : -40)
                        .clipped()
                } else {
                    // Empty colored space for breathwork
                    Constants.Colors.primaryBlue.opacity(0.05)
                        .frame(height: 160)
                }
            }

            // White content section at bottom
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Constants.Colors.textPrimary)

                Text(description)
                    .font(Constants.Typography.body)
                    .foregroundColor(Constants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, Constants.Spacing.standard)
            .background(Color.white)
        }
        .cornerRadius(Constants.CornerRadius.card)
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                .stroke(Constants.Colors.accentOrange, lineWidth: 5)
        )
        .shadow(
            color: Constants.Shadow.color,
            radius: Constants.Shadow.radius,
            x: Constants.Shadow.x,
            y: Constants.Shadow.y
        )
    }
}

enum ActivityType {
    case meditation
    case breathwork
}

#Preview {
    ActivityTypeSelectionView { type, duration in
        print("Selected: \(type) for \(duration) minutes")
    }
}

#Preview("Activity Cards") {
    VStack(spacing: 16) {
        ActivityTypeCard(
            title: "Meditation",
            description: "Lugn och närvaro",
            backgroundImage: "Card-background-meditation"
        )

        ActivityTypeCard(
            title: "Breathwork",
            description: "Andningsövningar",
            backgroundImage: nil
        )
    }
    .padding()
    .background(Constants.Colors.backgroundBeige)
}
