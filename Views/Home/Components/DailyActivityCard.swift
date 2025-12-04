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
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    // Label
                    Text(activity.label)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(
                            activity.isCompleted
                            ? Constants.Colors.textTertiary
                            : Constants.Colors.accentOrange
                        )
                        .tracking(1.0)

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

                // Icon
                ZStack {
                    if activity.id == "morning_breath" {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                activity.isCompleted
                                ? Color.gray.opacity(0.1)
                                : Constants.Colors.accentOrange.opacity(0.1)
                            )
                            .frame(width: 80, height: 80)

                        Image("Coffe1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .opacity(activity.isCompleted ? 0.5 : 1.0)
                    } else if activity.id == "midday_reset" {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                activity.isCompleted
                                ? Color.gray.opacity(0.1)
                                : Constants.Colors.accentOrange.opacity(0.1)
                            )
                            .frame(width: 80, height: 80)

                        Image("Sun")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .opacity(activity.isCompleted ? 0.5 : 1.0)
                    } else if activity.id == "evening_reflection" {
                        Image("Star")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .opacity(activity.isCompleted ? 0.5 : 1.0)
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                activity.isCompleted
                                ? Color.gray.opacity(0.1)
                                : Constants.Colors.accentOrange.opacity(0.1)
                            )
                            .frame(width: 48, height: 48)

                        Image(systemName: activity.icon)
                            .font(.system(size: 22))
                            .foregroundColor(
                                activity.isCompleted
                                ? .gray
                                : Constants.Colors.accentOrange
                            )
                    }
                }
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
                        : Constants.Colors.accentOrange,
                        lineWidth: 6
                    )
            )
            .overlay(
                // Accent bar on left
                Rectangle()
                    .fill(
                        activity.isCompleted
                        ? Color.gray.opacity(0.3)
                        : Constants.Colors.accentOrange
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
