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
            // Title
            VStack(spacing: 8) {
                Text(Strings.DurationSelection.title)
                    .font(Constants.Typography.title)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)

                Text(Strings.DurationSelection.subtitle(activityType: activityType == .meditation ? "meditation" : "breathwork"))
                    .font(Constants.Typography.body)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
            }
            .padding(.top, 60)

            Spacer()

            // Duration options
            VStack(spacing: 20) {
                ForEach(durations, id: \.self) { duration in
                    DurationCard(duration: duration) {
                        onSelectDuration(duration)
                    }
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
    }
}

// MARK: - Duration Card
struct DurationCard: View {
    let duration: Int
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Spacer()

                Text("\(duration) min")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Constants.Colors.textPrimary)

                Spacer()
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(Constants.CornerRadius.card)
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
}

#Preview {
    DurationSelectionView(activityType: .meditation) { duration in
        print("Selected: \(duration) minutes")
    }
}
