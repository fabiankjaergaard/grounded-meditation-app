//
//  DailyActivityCard.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct DailyActivityCard: View {
    let activity: Activity
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            activity.isCompleted
                            ? Color.gray.opacity(0.1)
                            : Constants.Colors.primaryBlue.opacity(0.1)
                        )
                        .frame(width: 56, height: 56)

                    Image(systemName: activity.icon)
                        .font(.system(size: 24))
                        .foregroundColor(
                            activity.isCompleted
                            ? .gray
                            : Constants.Colors.primaryBlue
                        )
                }

                // Content
                VStack(alignment: .leading, spacing: 4) {
                    // Label
                    Text(activity.label)
                        .font(Constants.Typography.label)
                        .foregroundColor(
                            activity.isCompleted
                            ? Constants.Colors.textTertiary
                            : Constants.Colors.primaryBlue
                        )
                        .tracking(1.2)

                    // Title
                    Text(activity.title)
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(
                            activity.isCompleted
                            ? Constants.Colors.textTertiary
                            : Constants.Colors.textPrimary
                        )
                        .strikethrough(activity.isCompleted)

                    // Subtitle
                    Text(activity.subtitle)
                        .font(Constants.Typography.caption)
                        .foregroundColor(Constants.Colors.textSecondary)
                }

                Spacer()

                // Duration
                Text(activity.duration)
                    .font(Constants.Typography.caption)
                    .foregroundColor(
                        activity.isCompleted
                        ? Constants.Colors.textTertiary
                        : Constants.Colors.primaryBlue
                    )
            }
            .padding(16)
            .background(
                activity.isCompleted
                ? Color(hex: "#F8F9FA")
                : Constants.Colors.cardBackground
            )
            .overlay(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                    .stroke(
                        activity.isCompleted
                        ? Constants.Colors.borderDefault
                        : Constants.Colors.primaryBlue,
                        lineWidth: 2
                    )
            )
            .overlay(
                // Accent bar on left
                Rectangle()
                    .fill(
                        activity.isCompleted
                        ? Color.gray.opacity(0.3)
                        : Constants.Colors.primaryBlue
                    )
                    .frame(width: 4)
                    .cornerRadius(2),
                alignment: .leading
            )
            .cornerRadius(Constants.CornerRadius.card)
            .opacity(activity.isCompleted ? 0.6 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(activity.isCompleted)
    }
}

#Preview {
    VStack(spacing: 16) {
        DailyActivityCard(activity: Activity.morningBreath) {
            print("Tapped")
        }

        DailyActivityCard(
            activity: Activity(
                id: "test",
                label: "MORGON",
                title: "Morgonandning",
                subtitle: "Aktivera kropp & sinne",
                duration: "5 min",
                icon: "heart.fill",
                type: .breathwork,
                isCompleted: true
            )
        ) {
            print("Tapped")
        }
    }
    .padding()
    .background(Constants.Colors.backgroundBeige)
}
