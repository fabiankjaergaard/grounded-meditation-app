//
//  BonusActivityCard.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct BonusActivityCard: View {
    let activity: Activity
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Har du mer tid?")
                    .font(Constants.Typography.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Constants.Colors.textSecondary)

                Spacer()
            }
            .padding(.vertical, Constants.Spacing.md)
            .padding(.horizontal, Constants.Spacing.standard)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .fill(Constants.Colors.borderDefault)
                    .frame(height: 1),
                alignment: .top
            )

            // Activity Card
            Button(action: onTap) {
                HStack(spacing: 16) {
                    // Icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Constants.Colors.accentYellow.opacity(0.2))
                            .frame(width: 56, height: 56)

                        Image(systemName: activity.icon)
                            .font(.system(size: 24))
                            .foregroundColor(Constants.Colors.primaryBlue)
                    }

                    // Content
                    VStack(alignment: .leading, spacing: 4) {
                        Text(activity.title)
                            .font(Constants.Typography.bodyBold)
                            .foregroundColor(Constants.Colors.textPrimary)

                        Text(activity.subtitle)
                            .font(Constants.Typography.caption)
                            .foregroundColor(Constants.Colors.textSecondary)
                    }

                    Spacer()

                    // Duration & Arrow
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(activity.duration)
                            .font(Constants.Typography.caption)
                            .foregroundColor(Constants.Colors.primaryBlue)

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(Constants.Colors.textTertiary)
                    }
                }
                .padding(16)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                .stroke(Constants.Colors.borderDefault, lineWidth: 1)
        )
        .shadow(
            color: Constants.Shadow.color,
            radius: Constants.Shadow.radius,
            x: Constants.Shadow.x,
            y: Constants.Shadow.y
        )
    }
}

#Preview {
    BonusActivityCard(activity: Activity.dynamicMeditation) {
        print("Tapped")
    }
    .padding()
    .background(Constants.Colors.backgroundBeige)
}
