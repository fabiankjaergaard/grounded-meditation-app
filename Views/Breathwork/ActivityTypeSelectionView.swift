//
//  ActivityTypeSelectionView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-04.
//

import SwiftUI

struct ActivityTypeSelectionView: View {
    @Environment(\.dismiss) var dismiss
    let onSelectType: (ActivityType) -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Spacing.standard) {
                Spacer()

                // Title
                VStack(spacing: 8) {
                    Text("Välj aktivitet")
                        .font(Constants.Typography.title)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text("Hur vill du börja din dag?")
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textSecondary)
                }

                Spacer()
                    .frame(height: 40)

                // Activity type options
                VStack(spacing: 16) {
                    ActivityTypeCard(
                        title: "Meditation",
                        description: "Lugn och närvaro",
                        backgroundImage: "Card-background-meditation"
                    ) {
                        onSelectType(.meditation)
                    }

                    ActivityTypeCard(
                        title: "Breathwork",
                        description: "Andningsövningar",
                        backgroundImage: nil
                    ) {
                        onSelectType(.breathwork)
                    }
                }

                Spacer()
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
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                // Background image or empty section
                ZStack {
                    if let backgroundImage = backgroundImage {
                        Image(backgroundImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .clipped()
                    } else {
                        // Empty colored space for breathwork
                        Constants.Colors.primaryBlue.opacity(0.05)
                            .frame(height: 180)
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
                .padding(Constants.Spacing.standard)
                .background(Color.white)
            }
            .cornerRadius(Constants.CornerRadius.card)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                    .stroke(Constants.Colors.primaryBlue, lineWidth: 2)
            )
            .shadow(
                color: Constants.Shadow.color,
                radius: Constants.Shadow.radius,
                x: Constants.Shadow.x,
                y: Constants.Shadow.y
            )
        }
    }
}

enum ActivityType {
    case meditation
    case breathwork
}

#Preview {
    ActivityTypeSelectionView { type in
        print("Selected: \(type)")
    }
}

#Preview("Activity Cards") {
    VStack(spacing: 16) {
        ActivityTypeCard(
            title: "Meditation",
            description: "Lugn och närvaro",
            backgroundImage: "Card-background-meditation"
        ) {
            print("Meditation tapped")
        }

        ActivityTypeCard(
            title: "Breathwork",
            description: "Andningsövningar",
            backgroundImage: nil
        ) {
            print("Breathwork tapped")
        }
    }
    .padding()
    .background(Constants.Colors.backgroundBeige)
}
