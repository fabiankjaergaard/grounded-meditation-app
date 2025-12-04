//
//  DurationSelectionView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct DurationSelectionView: View {
    @Environment(\.dismiss) var dismiss
    let activityType: ActivityType
    let onSelectDuration: (Int) -> Void

    let durations = [5, 10, 15, 20]

    var body: some View {
        VStack(spacing: Constants.Spacing.standard) {
            Spacer()

            // Title
            VStack(spacing: 8) {
                Text(Strings.DurationSelection.title)
                    .font(Constants.Typography.title)
                    .foregroundColor(Constants.Colors.textPrimary)

                Text(Strings.DurationSelection.subtitle(activityType: activityType == .meditation ? "meditation" : "breathwork"))
                    .font(Constants.Typography.body)
                    .foregroundColor(Constants.Colors.textSecondary)
            }

            Spacer()
                .frame(height: 24)

            // Duration options
            VStack(spacing: 12) {
                ForEach(durations, id: \.self) { duration in
                    DurationCard(duration: duration) {
                        onSelectDuration(duration)
                    }
                }
            }

            Spacer()
                .frame(minHeight: 20)
        }
        .padding(Constants.Spacing.standard)
        .background(
            Image("Card-background-meditation")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Duration Card
struct DurationCard: View {
    let duration: Int
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Clock icon
                ZStack {
                    Circle()
                        .fill(Constants.Colors.primaryBlue.opacity(0.1))
                        .frame(width: 48, height: 48)

                    Image(systemName: Constants.Icons.clock)
                        .font(.system(size: 20))
                        .foregroundColor(Constants.Colors.primaryBlue)
                }

                // Duration text
                HStack(spacing: 6) {
                    Text("\(duration)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text(Strings.DurationSelection.minutes)
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textSecondary)
                }

                Spacer()

                Image(systemName: Constants.Icons.chevronRight)
                    .foregroundColor(Constants.Colors.textTertiary)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(Constants.CornerRadius.card)
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

#Preview {
    DurationSelectionView(activityType: .meditation) { duration in
        print("Selected: \(duration) minutes")
    }
}
