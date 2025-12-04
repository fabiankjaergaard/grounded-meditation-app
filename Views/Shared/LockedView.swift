//
//  LockedView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct LockedView: View {
    let featureName: String
    let description: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: Constants.Spacing.standard) {
            Spacer()

            // Lock icon
            ZStack {
                Circle()
                    .fill(Constants.Colors.primaryBlue.opacity(0.1))
                    .frame(width: 120, height: 120)

                Image(systemName: Constants.Icons.lock)
                    .font(.system(size: 48))
                    .foregroundColor(Constants.Colors.primaryBlue)
            }

            // Title
            Text("Kommer snart")
                .font(Constants.Typography.title)
                .foregroundColor(Constants.Colors.textPrimary)

            // Feature name
            Text(featureName)
                .font(Constants.Typography.headline)
                .foregroundColor(Constants.Colors.primaryBlue)

            // Description
            Text(description)
                .font(Constants.Typography.body)
                .foregroundColor(Constants.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Constants.Spacing.xl)

            Spacer()

            // Back button (optional)
            Button(action: { dismiss() }) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Tillbaka")
                }
                .font(Constants.Typography.bodyBold)
                .foregroundColor(Constants.Colors.primaryBlue)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: Constants.CornerRadius.button)
                        .stroke(Constants.Colors.primaryBlue, lineWidth: 2)
                )
            }
            .padding(.horizontal, Constants.Spacing.standard)
            .padding(.bottom, Constants.Spacing.xl)
        }
        .background(Constants.Colors.backgroundBeige)
    }
}

#Preview {
    LockedView(
        featureName: "Community",
        description: "Denna funktion kommer snart. Håll utkik efter uppdateringar!"
    )
}
