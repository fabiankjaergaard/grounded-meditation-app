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
                        icon: "sparkles",
                        title: "Meditation",
                        description: "Lugn och närvaro",
                        backgroundImage: "Card-background-meditation"
                    ) {
                        onSelectType(.meditation)
                    }

                    ActivityTypeCard(
                        icon: "wind",
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
            .background(
                Image("Card-background-meditation")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
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
    let icon: String
    let title: String
    let description: String
    let backgroundImage: String?
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 20) {
                // Icon
                ZStack {
                    Circle()
                        .fill(Constants.Colors.primaryBlue.opacity(0.1))
                        .frame(width: 64, height: 64)

                    Image(systemName: icon)
                        .font(.system(size: 28))
                        .foregroundColor(Constants.Colors.primaryBlue)
                }

                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(backgroundImage != nil ? .white : Constants.Colors.textPrimary)

                    Text(description)
                        .font(Constants.Typography.subheadline)
                        .foregroundColor(backgroundImage != nil ? .white.opacity(0.9) : Constants.Colors.textSecondary)
                }

                Spacer()

                Image(systemName: Constants.Icons.chevronRight)
                    .foregroundColor(backgroundImage != nil ? .white.opacity(0.7) : Constants.Colors.textTertiary)
            }
            .padding(Constants.Spacing.standard)
            .background(
                Group {
                    if let backgroundImage = backgroundImage {
                        Image(backgroundImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Color.white
                    }
                }
            )
            .cornerRadius(Constants.CornerRadius.card)
            .clipped()
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

#Preview("Meditation Card") {
    VStack {
        ActivityTypeCard(
            icon: "sparkles",
            title: "Meditation",
            description: "Lugn och närvaro",
            backgroundImage: "Card-background-meditation"
        ) {
            print("Meditation tapped")
        }

        ActivityTypeCard(
            icon: "wind",
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
