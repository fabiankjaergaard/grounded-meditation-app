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
                        description: "Lugn och närvaro"
                    ) {
                        onSelectType(.meditation)
                    }

                    ActivityTypeCard(
                        icon: "wind",
                        title: "Breathwork",
                        description: "Andningsövningar"
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
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text(description)
                        .font(Constants.Typography.subheadline)
                        .foregroundColor(Constants.Colors.textSecondary)
                }

                Spacer()

                Image(systemName: Constants.Icons.chevronRight)
                    .foregroundColor(Constants.Colors.textTertiary)
            }
            .padding(Constants.Spacing.standard)
            .background(Color.white)
            .cornerRadius(Constants.CornerRadius.card)
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
